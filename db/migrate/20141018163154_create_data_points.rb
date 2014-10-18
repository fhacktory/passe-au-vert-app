class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.references :traffic_light, index: true
      t.datetime :created_at
      t.integer :changed_state
    end
  end
end
