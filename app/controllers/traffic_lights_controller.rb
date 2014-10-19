class TrafficLightsController < ApplicationController

  before_action :set_traffic_light, only: [:data_points, :show]

  CLOSES_LIMIT = 100
  MINIMAL_FIELDS = [:id, :latitude, :longitude]

  def close_to
  	traffic_lights = TrafficLight.select(*MINIMAL_FIELDS).close_to(latitude: params[:latitude].to_f, longitude: params[:longitude].to_f, limit: CLOSES_LIMIT)
  	render json: traffic_lights.map(&:to_map_info)
  end

  def index
  	@traffic_lights = TrafficLight.select(*MINIMAL_FIELDS)
  end

  def show
  end

  def data_points
  end

  private

  	def set_traffic_light
  	  @traffic_light = TrafficLight.find(params[:id])
  	end

end
