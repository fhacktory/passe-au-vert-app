class AddMoreComputedDataToTraficLights < ActiveRecord::Migration
  def change
  	add_column :traffic_lights, :green_time, :float
  end
end
