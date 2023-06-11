require 'rails_helper'

RSpec.describe Forecast do
  describe "Forecast Object", :vcr do
    it 'exists' do
      forecast = Forecast.new

      expect(forecast).to be_an Forecast
      expect(forecast.id).to eq(nil)
      expect(forecast.current_weather).to be_an Hash 
      expect(forecast.daily_weather).to be_an Array 
      expect(forecast.hourly_weather).to be_an Array
    end

    it "organize_current_weather method sets key/value pairs for current weather attribute" do

      attrs = WeatherapiService.new("39.74001,-104.99202", 5).forecast
      forecast = Forecast.new
  
      expect(forecast.current_weather).to_not have_key :last_updated
      expect(forecast.current_weather).to_not have_key :temperature
      expect(forecast.current_weather).to_not have_key :feels_like
      expect(forecast.current_weather).to_not have_key :humidity
      expect(forecast.current_weather).to_not have_key :uvi
      expect(forecast.current_weather).to_not have_key :visibility
      expect(forecast.current_weather).to_not have_key :condition
      expect(forecast.current_weather).to_not have_key :icon

      forecast.organize_current_weather(attrs)
      
      expect(forecast.current_weather).to have_key :last_updated
      expect(forecast.current_weather).to have_key :temperature
      expect(forecast.current_weather).to have_key :feels_like
      expect(forecast.current_weather).to have_key :humidity
      expect(forecast.current_weather).to have_key :uvi
      expect(forecast.current_weather).to have_key :visibility
      expect(forecast.current_weather).to have_key :condition
      expect(forecast.current_weather).to have_key :icon
    end

    it "organize_daily_weather method fills in daily_weather array with 5 day hashes with attributes" do
      attrs = WeatherapiService.new("39.74001,-104.99202", 5).forecast
      forecast = Forecast.new
  
      expect(forecast.daily_weather.count).to eq(0)

      forecast.organize_daily_weather(attrs)

      expect(forecast.daily_weather.count).to eq(5)

      forecast.daily_weather.each do |day|
        expect(day).to have_key :date
        expect(day).to have_key :sunrise
        expect(day).to have_key :sunset
        expect(day).to have_key :max_temp
        expect(day).to have_key :min_temp
        expect(day).to have_key :condition
        expect(day).to have_key :icon
      end
    end

    it "organize_hourly_weather method fills in hourly_weather array with 24 hour hashes with attributes" do
      attrs = WeatherapiService.new("39.74001,-104.99202", 5).forecast
      forecast = Forecast.new
  
      expect(forecast.hourly_weather.count).to eq(0)

      forecast.organize_hourly_weather(attrs)

      expect(forecast.hourly_weather.count).to eq(24)

      forecast.hourly_weather.each do |hour|
        expect(hour).to have_key :time
        expect(hour).to have_key :temperature
        expect(hour).to have_key :condition
        expect(hour).to have_key :icon
      end
    end
  end
end