class AddComputedDataToTraficLights < ActiveRecord::Migration
  def change
  	add_column :traffic_lights, :cycle_time, :float
  	add_column :traffic_lights, :offset, :float
  end
end
