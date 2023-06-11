class WeatherapiService
  def initialize(location, days)
    @location = location
    @days = days
  end

  def conn
    Faraday.new(url: "https://api.weatherapi.com") do |faraday|
      faraday.params["key"] = ENV["WEATHER_API_KEY"]
      faraday.params["q"] = @location
      faraday.params["days"] = @days
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def forecast
    get_url("/v1/forecast.json")
  end
end