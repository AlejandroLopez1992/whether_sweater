class Api::V0::ForecastController < ApplicationController
  before_action :initialize_facade

  def show
    render json: WeatherObjectSerialize.new
  end

  private

    def initialize_facade
      @facade = ForecastFacade.new(params[:location]).call_mapquest
    end
end