class RoadTripFacade

  def initialize(destination, origin, lat=nil, lng=nil)
    @destination = destination
    @origin = origin
    @lat = lat
    @lng = lng
  end

  def create_road_trip
    road_trip = RoadTrip.new 
    road_trip.start_city = @origin.gsub(",", ", ")
    road_trip.end_city = @origin.gsub(",", ", ")
    directions_object = call_mapquest_for_travel_time
    road_trip.travel_time = directions_object[:route][:formattedTime]
    formatted_location = call_mapquest_for_formatted_location
    weather_data = call_weather_api(formatted_location, 14)
    forecast = create_forecast(weather_data)
    
  end

  def call_mapquest_for_travel_time
    response = MapquestService.new(@destination, @origin).directions
  end

  def call_mapquest_for_formatted_location
    response = MapquestService.new(@destination).location 
    @lat = response[:results].first[:locations].first[:latLng][:lat]
    @lng = response[:results].first[:locations].first[:latLng][:lng]
    formatted_location = @lat.to_s + ", " + @lng.to_s
  end

  def create_forecast(weather_data)
    forecast = Forecast.new
    forecast.organize_current_weather(weather_data)
    forecast.organize_daily_weather(weather_data)
    forecast.organize_hourly_weather(weather_data)
    forecast
  end

  def call_weather_api(location, days)
    response = WeatherapiService.new(location, days).forecast
  end
end