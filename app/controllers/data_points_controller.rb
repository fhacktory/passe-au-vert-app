class DataPointsController < ApplicationController

  def create
  	attributes = data_point_params.merge(created_at: Time.now)
  	data_point = DataPoint.create!(attributes)
  	render json: data_point.id
  end

  private

	def data_point_params
	  params.permit(:traffic_light_id, :changed_state)
	end

end
