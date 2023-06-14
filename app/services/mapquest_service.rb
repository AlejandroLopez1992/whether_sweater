class MapquestService 

  def initialize(destination, origin=nil)
    @destination = destination
    @origin = origin
  end

  def location
    get_url("/geocoding/v1/address")
  end

  def directions
    get_url("/directions/v2/route")
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = ENV["MAPQUEST_API_KEY"]
      faraday.params["location"] = @destination
      faraday.params["from"] = @origin
      faraday.params["to"] = @destination
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end