class Api::V0::RoadTripController < ApplicationController
  wrap_parameters :road_trip, include: [:api_key, :destination, :origin]
  rescue_from ActionController::ParameterMissing, with: :not_raw_json

  def show
    @user = User.find_by_api_key(road_trip_params[:api_key])
    if @user
      if road_trip_params[:destination].empty? || road_trip_params[:origin].empty?
        render json: ErrorSerializer.new(road_trip_params).road_trip_params_empty, status: 400
      else
        road_trip_object = RoadTripFacade.new(road_trip_params[:destination], road_trip_params[:origin]).create_road_trip
        render json: RoadTripSerializer.new(road_trip_object).serializable_hash.to_json, status: 200
      end
    else
      render json: ErrorSerializer.new(@user).api_key_error, status: 401
    end
  end

  private

    def road_trip_params
      params.require(:road_trip).permit(:api_key, :destination, :origin)
    end

    def not_raw_json(error)
      render json: ErrorSerializer.new(error).parameters_not_in_raw_json_body_road_trip, status: 400
    end
end