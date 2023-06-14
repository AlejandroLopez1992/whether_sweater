require 'time'

class RoadTripFacade

  def initialize(destination, origin, lat=nil, lng=nil)
    @destination = destination
    @origin = origin
    @lat = lat
    @lng = lng
  end

  def create_road_trip
    road_trip = RoadTrip.new(@origin, @destination) 
    directions_object = call_mapquest_for_travel_time
    if directions_object[:route].has_key?(:routeError)
      road_trip.travel_time = "impossible"
      road_trip
    else
      road_trip.travel_time = directions_object[:route][:formattedTime]
      travel_time_in_seconds = directions_object[:route][:time]
      formatted_location = call_mapquest_for_formatted_location
      weather_data = call_weather_api(formatted_location, 14)
      date_time_of_arrival = determine_arrival_time(weather_data[:location][:localtime], travel_time_in_seconds)
      day_of_arrival = weather_data[:forecast][:forecastday].find { |day| day[:date] == date_time_of_arrival[:date] }
      hour_of_arrival = day_of_arrival[:hour].find { |hour| hour[:time] == date_time_of_arrival[:hour] }
      road_trip.weather_data(hour_of_arrival)
      road_trip
    end
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

  def call_weather_api(location, days)
    response = WeatherapiService.new(location, days).forecast
  end

  def determine_arrival_time(destination_time, travel_time)
    time = Time.parse(destination_time)
    arrival_time = time + travel_time
    formatted_time =  Hash.new
    formatted_time[:date] =  arrival_time.strftime("%Y-%m-%d")
    formatted_time[:hour] =  arrival_time.strftime("%Y-%m-%d %H:00")
    formatted_time
  end
end