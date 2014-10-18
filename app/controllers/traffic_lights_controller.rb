class TrafficLightsController < ApplicationController
  def index
  	@traffic_lights = TrafficLight.select(:id, :latitude, :longitude)
  end
end
