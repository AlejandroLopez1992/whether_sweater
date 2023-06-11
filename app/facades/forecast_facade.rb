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
    call_weather_api(formatted_location, 5)
  end

  def call_weather_api(location, days)
    response = WeatherapiService.new(location, days).forecast
    require 'pry'; binding.pry
  end
end