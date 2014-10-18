class CreateTrafficLights < ActiveRecord::Migration
  def change
    create_table :traffic_lights do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
