class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize
    @id = nil
    @current_weather = Hash.new
    @daily_weather = [ ]
    @hourly_weather = [ ]
  end

  def organize_current_weather(weather_data)
    @current_weather[:last_updated] = weather_data[:current][:last_updated]
    @current_weather[:temperature] = weather_data[:current][:temp_f]
    @current_weather[:feels_like] = weather_data[:current][:feelslike_f]
    @current_weather[:humidity] = weather_data[:current][:humidity]
    @current_weather[:uvi] = weather_data[:current][:uv]
    @current_weather[:visibility] = weather_data[:current][:vis_miles]
    @current_weather[:condition] = weather_data[:current][:condition][:text]
    @current_weather[:icon] = weather_data[:current][:condition][:icon]
  end

  def organize_daily_weather(weather_data)
    weather_data[:forecast][:forecastday].each do |day|
      day_hash = Hash.new
      day_hash[:date] = day[:date]
      day_hash[:sunrise] = day[:astro][:sunrise]
      day_hash[:sunset] = day[:astro][:sunset]
      day_hash[:max_temp] = day[:day][:maxtemp_f]
      day_hash[:min_temp] = day[:day][:mintemp_f]
      day_hash[:condition] = day[:day][:condition][:text]
      day_hash[:icon] = day[:day][:condition][:icon]
      @daily_weather.push(day_hash)
    end
  end
end