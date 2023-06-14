class Api::V0::RoadTripController < ApplicationController
  wrap_parameters :road_trip, include: [:api_key, :destination, :origin]

  def show
    @user = User.find_by_api_key(road_trip_params[:api_key])
    if @user
      road_trip_object = RoadTripFacade.new(road_trip_params[:destination], road_trip_params[:origin]).create_road_trip
      render json: RoadTripSerializer.new(road_trip_object).serializable_hash.to_json, status: 200
    else
      render json: ErrorSerializer.new(@user).api_key_error, status: 401
    end
  end

  private

    def road_trip_params
      params.require(:road_trip).permit(:api_key, :destination, :origin)
    end
end