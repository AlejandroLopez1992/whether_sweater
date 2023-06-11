class Api::V0::ForecastController < ApplicationController

  def show
    forecast = ForecastFacade.new(params[:location]).call_mapquest
    render json: ForecastSerializer.new(forecast).serializable_hash.to_json
  end
end