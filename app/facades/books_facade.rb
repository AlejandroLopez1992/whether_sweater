class BooksFacade

  def initialize(location, quantity, lat=nil, lng=nil)
    @location = location
    @quantity = quantity
    @lat = lat
    @lng = lng
  end

  def call_mapquest
    response = MapquestService.new(@location).location
    @lat = response[:results].first[:locations].first[:latLng][:lat]
    @lng = response[:results].first[:locations].first[:latLng][:lng]
    formatted_location = @lat.to_s + ", " + @lng.to_s
    call_weather_api(formatted_location, 1)
  end

  def call_weather_api(location, days)
    response = WeatherapiService.new(location, days).forecast
    create_books_data(response)
  end

  def create_books_data(forecast)
    response = OpenlibraryService.new(@location, @quantity).search
    
  end
end