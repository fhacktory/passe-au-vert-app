class TrafficLight < ActiveRecord::Base

  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   # distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  has_many :data_points

  validates_presence_of :latitude, :longitude
  validates_uniqueness_of :data_id

  MAXIMUM_TIME_BETWEEN_POINTS = 40 # In seconds


  def self.close_to(latitude: latitude, longitude: longitude, distance: 5, limit: 20)
    within(distance, origin: [latitude, longitude]).limit(limit)
  end

  def self.compute_data!
    with_data_points.map { |traffic_light|
      (traffic_light.compute_data! || {}).merge(id: traffic_light.id)
    }.compact
  end

  def self.ids_with_data_points
    DataPoint.pluck(:traffic_light_id).uniq
  end

  # Reentrant import.
  def self.import(filename = Rails.root.join('public/feux.csv'))
  	traffic_lights_imported = []

  	require 'csv'

  	CSV.foreach(filename, headers: true) do |row|
  	  attributes = row.to_h
  	  data_id = attributes.delete('id') || attributes.delete(nil)

  	  traffic_light = where(data_id: data_id).first_or_initialize
  	  traffic_light.assign_attributes(attributes)
  	  traffic_light.save!

  	  traffic_lights_imported << traffic_light
    end

    traffic_lights_imported
	end

  def self.with_data_points
    where(id: ids_with_data_points)
  end


  # Data in seconds.
  def compute_data
    data_points_by_time = data_points.order('created_at ASC')
    if data_points_by_time.count > 2

      red_to_greens = data_points_by_time.with_changed_state(:red_to_green)
      cycle_time_by_red_to_greens = if red_to_greens.count >= 2
        (red_to_greens.last.created_at - red_to_greens.first.created_at).to_f / (red_to_greens.count - 1)
      else
        0
      end

      green_to_oranges = data_points_by_time.with_changed_state(:green_to_orange)
      cycle_time_by_green_to_oranges = if green_to_oranges.count >= 2
        (green_to_oranges.last.created_at - green_to_oranges.first.created_at).to_f / (green_to_oranges.count - 1)
      else
        0
      end

      if (cycle_time_by_red_to_greens + cycle_time_by_green_to_oranges) > 0
        cycle_time = (cycle_time_by_red_to_greens * red_to_greens.count + cycle_time_by_green_to_oranges * green_to_oranges.count) /
                     (red_to_greens.count + green_to_oranges.count)

        accumulated_green_time = 0
        accumulated_green_time_count = 0
        accumulated_offset = 0

        red_to_greens.each do |red_to_green|
          accumulated_offset += (red_to_green.created_at.to_i % cycle_time)

          if next_data_point = data_points_by_time.where('created_at > ?', red_to_green.created_at).first
            if next_data_point.changed_state != :red_to_green
              accumulated_green_time += next_data_point.created_at - red_to_green.created_at
              accumulated_green_time_count +=1
            end
          end
        end

        offset = accumulated_offset.to_f / red_to_greens.count if red_to_greens.any?
        green_time = accumulated_green_time.to_f / accumulated_green_time_count if accumulated_green_time_count > 0

        {
          cycle_time: cycle_time,
          green_time: green_time,
          offset: offset
        }

      end

    end
  end

  def compute_data!
    if _compute_data = compute_data
      assign_attributes(_compute_data)
      save!

      _compute_data
    end
  end

  def computed_data?
    cycle_time.present? || offset.present?
  end

  def state_at(time = Time.now, reload = true)
    return @state_at if defined? @state_at

    @state_at = if offset && cycle_time && green_time

      time_offset = (time.to_i - offset) % cycle_time
      if time_offset < green_time
        state = :green
        remaining_time = green_time - time_offset
      else
        state = :red
        remaining_time = cycle_time - time_offset
      end

      if state && remaining_time
        {
          state: state,
          remaining_time: remaining_time
        }
      end

    end
  end

  def state
    state_at
  end

	def to_map_info
    {
      id: id,
      latitude: latitude,
      longitude: longitude
    }
  end

end
