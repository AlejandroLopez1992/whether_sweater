class RoadTrip 
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(start_city, end_city, travel_time=nil)
    @id = nil
    @start_city = start_city
    @end_city = end_city
    @travel_time = travel_time
    @weather_at_eta = Hash.new
  end
end