class MapquestService 

  def initialize(data)
    @data = data
  end

  def location
    get_url("/geocoding/v1/address")
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = ENV["MAPQUEST_API_KEY"]
      faraday.params["location"] = @data
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end