require 'rails_helper'

RSpec.describe WeatherapiService do
  context "instance methods", :vcr do
    it "forecast method returns weather forcast data" do
      search = WeatherapiService.new("39.74001,-104.99202", "5").forecast
      expect(search).to be_a Hash

      expect(search).to have_key :location
      expect(search[:location]).to be_an Hash
      
      expect(search).to have_key :current
      expect(search[:current]).to be_an Hash

      current_weather_data = search[:current]
      expect(current_weather_data).to have_key :last_updated
      expect(current_weather_data[:last_updated]).to be_an String 

      expect(current_weather_data).to have_key :temp_f
      expect(current_weather_data[:temp_f]).to be_an Float
      
      expect(current_weather_data).to have_key :feelslike_f
      expect(current_weather_data[:feelslike_f]).to be_an Float

      expect(current_weather_data).to have_key :feelslike_f
      expect(current_weather_data[:feelslike_f]).to be_an Float

      expect(current_weather_data).to have_key :humidity
      expect(current_weather_data[:humidity]).to be_an Integer 

      expect(current_weather_data).to have_key :uv
      expect(current_weather_data[:uv]).to be_an Float

      expect(current_weather_data).to have_key :vis_miles
      expect(current_weather_data[:vis_miles]).to be_an Float

      expect(current_weather_data).to have_key :condition
      expect(current_weather_data[:condition]).to be_an Hash

      expect(current_weather_data[:condtition]).to have_key :text
      expect(current_weather_data[:condtition][:text]).to be_an String 

      expect(current_weather_data[:condtition]).to have_key :icon
      expect(current_weather_data[:condtition][:icon]).to be_an String 

      expect(search).to have_key :forecast
      expect(search[:forecast]).to be_an Hash 

      daily_weather_data = search[:forecast]
      expect(daily_weather_data).to have_key :forecastday
      expect(daily_weather_data[:forecastday]).to be_an Array 

      first_day_weather_data = search[:forecast][:forecastday].first
      expect(first_day_weather_data).to have_key :date 
      expect(first_day_weather_data[:date]).to be_an String 

      expect(first_day_weather_data).to have_key :astro 
      expect(first_day_weather_data[:astro]).to be_an Hash 

      expect(first_day_weather_data[:astro]).to have_key :sunrise
      expect(first_day_weather_data[:astro][:sunrise]).to be_an String
      
      expect(first_day_weather_data[:astro]).to have_key :sunset 
      expect(first_day_weather_data[:astro][:sunset]).to be_an String 

      expect(first_day_weather_data).to have_key :day 
      expect(first_day_weather_data[:day]).to be_an Hash 

      expect(first_day_weather_data[:day]).to have_key :maxtemp_f
      expect(first_day_weather_data[:day][:maxtemp_f]).to be_an Float 

      expect(first_day_weather_data[:day]).to have_key :mintemp_f 
      expect(first_day_weather_data[:day][:mintemp_f]).to be_an Float 

      expect(first_day_weather_data[:day]).to have_key :condition
      expect(first_day_weather_data[:day][:condtition]).to be_an Hash 

      expect(first_day_weather_data[:day][:condition]).to have_key :text
      expect(first_day_weather_data[:day][:condition][:text]).to be_an String 

      expect(first_day_weather_data[:day][:condition]).to have_key :icon
      expect(first_day_weather_data[:day][:condition][:icon]).to be_an String 

      expect(first_day_weather_data).to have_key :hour
      expect(first_day_weather_data[:hour]).to be_an Array

      hourly_weather_data = first_day_weather_data[:hour].first

      expect(hourly_weather_data).to have_key :time 
      expect(hourly_weather_data[:time]).to be_an String 

      expect(hourly_weather_data).to have_key :temp_f 
      expect(hourly_weather_data[:temp_f]).to be_an Float

      expect(hourly_weather_data).to have_key :condition 
      expect(hourly_weather_data[:condition]).to be_an Hash 

      expect(hourly_weather_data[:condition]).to have_key :text
      expect(hourly_weather_data[:condition][:text]).to be_an String

      expect(hourly_weather_data[:condition]).to have_key :icon
      expect(hourly_weather_data[:condition][:icon]).to be_an String 
    end
  end
end
