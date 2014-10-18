class TrafficLight < ActiveRecord::Base

  validates_presence_of :latitude, :longitude
  validates_uniqueness_of :data_id

  # Reentrant import.
  def self.import(filename = Rails.root.join('public/feux.csv'))
  	traffic_lights_imported = []

  	require 'csv'

  	CSV.foreach(filename, headers: true) do |row|
  	  attributes = row.to_h
  	  data_id = attributes.delete('id') || attributes.delete(nil)

  	  traffic_light = first_or_initialize(data_id: data_id)
  	  traffic_light.assign_attributes(attributes)
  	  traffic_light.save!

  	  traffic_lights_imported << traffic_light
    end

    traffic_lights_imported
	end

	def to_map_info
    {
      title: "ID #{id}",
      content: "Position: #{latitude}, #{longitude}",
      latitude: latitude,
      longitude: longitude
    }.to_json
  end

end
