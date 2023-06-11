class Api::V0::ForecastController < ApplicationController

  def show
    if params[:location]
      forecast = ForecastFacade.new(params[:location]).call_mapquest
      render json: ForecastSerializer.new(forecast).serializable_hash.to_json, status: 200
    else
      render json: ErrorSerializer.new(params).location_params_missing, status: 400
    end
  end
end