class RoadTrip 
  attr_accessor :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(start_city, end_city)
    @id = nil
    @start_city = start_city.gsub(",", ", ")
    @end_city = end_city.gsub(",", ", ")
    @travel_time = nil
    @weather_at_eta = Hash.new
  end

  def weather_data(forecast_hour)
    @weather_at_eta[:datetime] = forecast_hour[:time]
    @weather_at_eta[:temperature] = forecast_hour[:temp_f]
    @weather_at_eta[:condition] = forecast_hour[:condition][:text]
  end
end