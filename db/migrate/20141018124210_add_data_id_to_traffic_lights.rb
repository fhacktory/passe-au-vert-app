class AddDataIdToTrafficLights < ActiveRecord::Migration
  def change
  	add_column :traffic_lights, :data_id, :integer, unique: true
  end
end
