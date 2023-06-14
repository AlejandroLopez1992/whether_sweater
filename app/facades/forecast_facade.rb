class ForecastFacade

  def initialize(location, lat=nil, lng=nil)
    @location = location
    @lat = lat
    @lng = lng
  end

  def call_mapquest
    response = MapquestService.new(@location).location
    @lat = response[:results].first[:locations].first[:latLng][:lat]
    @lng = response[:results].first[:locations].first[:latLng][:lng]
    formatted_location = @lat.to_s + ", " + @lng.to_s
  end

  def call_weather_api(location, days)
    response = WeatherapiService.new(location, days).forecast
  end

  def create_forecast(weather_data)
    forecast = Forecast.new
    forecast.organize_current_weather(weather_data)
    forecast.organize_daily_weather(weather_data)
    forecast.organize_hourly_weather(weather_data)
    forecast
  end

  def forecast_five_days
    formatted_location = call_mapquest
    weather_data = call_weather_api(formatted_location, 5)
    create_forecast(weather_data)
  end
end