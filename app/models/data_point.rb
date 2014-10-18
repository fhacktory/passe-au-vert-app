class DataPoint < ActiveRecord::Base
  extend Enumerize

  belongs_to :traffic_light
  enumerize :changed_state, in: {
    red_to_green: 1,
    green_to_orange: 2,
    orange_to_red: 3
  }, scope: true

  validates_presence_of :traffic_light_id, :created_at, :changed_state

end
