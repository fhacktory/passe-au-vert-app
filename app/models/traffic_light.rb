class TrafficLight < ActiveRecord::Base

  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   # distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  has_many :data_points

  validates_presence_of :latitude, :longitude
  validates_uniqueness_of :data_id

  def self.close_to(latitude: latitude, longitude: longitude, distance: 5, limit: 20)
    within(distance, origin: [latitude, longitude]).limit(limit)
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


	def to_map_info
    {
      id: id,
      latitude: latitude,
      longitude: longitude
    }
  end

end
