class Api::V0::RoadTripController < ApplicationController
  wrap_parameters :road_trip, include: [:api_key, :destination, :origin]
  def show
    if User.find_by_api_key(road_trip_params[:api_key])
      road_trip_object = RoadTripFacade.new(road_trip_params[:destination], road_trip_params[:origin]).create_road_trip
      render json: RoadTripSerializer.new(road_trip_object).serializable_hash.to_json, status: 200
    end
  end

  private

    def road_trip_params
      params.require(:road_trip).permit(:api_key, :destination, :origin)
    end
end