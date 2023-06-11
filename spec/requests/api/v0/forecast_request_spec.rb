require 'rails_helper'

describe "Forecast API" do
  describe "GET /api/v0/forecast?location=city,state", :vcr do
    it "provides weather data with 5 days of forcast" do

      get "/api/v0/forecast?location=Denver,CO"

      expect(response).to be_succesful

      weather_data = JSON.parse(response.body, symbolize_names: true)

      expect(weather_data.count).to eq(1)

      expect(weather_data).to have_key(:id)
      expect(weather_data[:id]).to eq(nil)

      expect(weather_data).to have_key(:type)
      expect(weather_data[:type]).to eq("forecast")

      expect(weather_data).to have_key(:attributes)
      expect(weather_data[:attributes]).to be_an Hash

      expect(weather_data[:attributes]).to have_key(:current_weather)
      expect(weather_data[:attributes][:current_weather]).to be_an Hash

      current_weather_data = weather_data[:attributes][:current_weather]

      expect(current_weather_data).to have_key :last_updated
      expect(current_weather_data[:last_updated]).to be_an String

      expect(current_weather_data).to have_key :temperature
      expect(current_weather_data[:temperature]).to be_an Float

      expect(current_weather_data).to have_key :feels_like
      expect(current_weather_data[:feels_like]).to be_an Float
      
      expect(current_weather_data).to have_key :humidity
      expect(current_weather_data[:humidity]).to be_an Integer

      expect(current_weather_data).to have_key :uvi
      expect(current_weather_data[:uvi]).to be_an Float

      expect(current_weather_data).to have_key :visibility
      expect(current_weather_data[:visibility]).to be_an Float

      expect(current_weather_data).to have_key :condition
      expect(current_weather_data[:condition]).to be_an String

      expect(current_weather_data).to have_key :icon
      expect(current_weather_data[:icon]).to be_an String

      #Check for attributes not passed for Weather API
      expect(current_weather_data).to_not have_key :last_updated_epoch
      expect(current_weather_data).to_not have_key :temp_c
      expect(current_weather_data).to_not have_key :temp_f
      expect(current_weather_data).to_not have_key :is_day
      expect(current_weather_data).to_not have_key :code
      expect(current_weather_data).to_not have_key :wind_mph
      expect(current_weather_data).to_not have_key :wind_kph
      expect(current_weather_data).to_not have_key :wind_degree
      expect(current_weather_data).to_not have_key :wind_dir
      expect(current_weather_data).to_not have_key :pressure_mb
      expect(current_weather_data).to_not have_key :pressure_in
      expect(current_weather_data).to_not have_key :precip_mm
      expect(current_weather_data).to_not have_key :precip_in
      expect(current_weather_data).to_not have_key :cloud
      expect(current_weather_data).to_not have_key :feelslike_c
      expect(current_weather_data).to_not have_key :feelslike_f
      expect(current_weather_data).to_not have_key :vis_km
      expect(current_weather_data).to_not have_key :vis_miles
      expect(current_weather_data).to_not have_key :uv
      expect(current_weather_data).to_not have_key :gust_mph
      expect(current_weather_data).to_not have_key :gust_kph

      expect(weather_data[:attributes]).to have_key(:daily_weather)
      expect(weather_data[:attributes][:daily_weather]).to be_an Array

      daily_weather_data = weather_data[:attributes][:daily_weather]

      expect(daily_weather_data.count).to eq(5)

      daily_weather_data.each do |day|
        expect(daily_weather_data).to have_key :date
        expect(daily_weather_data[:date]).to be_an String

        expect(daily_weather_data).to have_key :sunrise
        expect(daily_weather_data[:sunrise]).to be_an String

        expect(daily_weather_data).to have_key :sunset
        expect(daily_weather_data[:sunset]).to be_an String

        expect(daily_weather_data).to have_key :max_temp
        expect(daily_weather_data[:max_temp]).to be_an Float

        expect(daily_weather_data).to have_key :min_temp
        expect(daily_weather_data[:min_temp]).to be_an Float

        expect(daily_weather_data).to have_key :condition
        expect(daily_weather_data[:condition]).to be_an String

        expect(daily_weather_data).to have_key :icon
        expect(daily_weather_data[:icon]).to be_an String

         #Check for attributes not passed for Weather API
        expect(daily_weather_data).to_not have_key :date_epoch
        expect(daily_weather_data).to_not have_key :maxtemp_c
        expect(daily_weather_data).to_not have_key :maxtemp_f
        expect(daily_weather_data).to_not have_key :mintemp_c
        expect(daily_weather_data).to_not have_key :mintemp_f
        expect(daily_weather_data).to_not have_key :avgtemp_c
        expect(daily_weather_data).to_not have_key :avgtemp_f
        expect(daily_weather_data).to_not have_key :maxwind_mph
        expect(daily_weather_data).to_not have_key :maxwind_kph
        expect(daily_weather_data).to_not have_key :totalprecip_mm
        expect(daily_weather_data).to_not have_key :totalprecip_in
        expect(daily_weather_data).to_not have_key :totalsnow_cm
        expect(daily_weather_data).to_not have_key :avgvis_km
        expect(daily_weather_data).to_not have_key :avgis_miles
        expect(daily_weather_data).to_not have_key :avghumidity
        expect(daily_weather_data).to_not have_key :daily_will_it_rain
        expect(daily_weather_data).to_not have_key :daily_chance_of_rain
        expect(daily_weather_data).to_not have_key :daily_will_it_snow
        expect(daily_weather_data).to_not have_key :daily_chance_of_snow
        expect(daily_weather_data).to_not have_key :text
        expect(daily_weather_data).to_not have_key :code
        expect(daily_weather_data).to_not have_key :uv
        expect(daily_weather_data).to_not have_key :astro
        expect(daily_weather_data).to_not have_key :moonrise
        expect(daily_weather_data).to_not have_key :moonset
        expect(daily_weather_data).to_not have_key :moon_phast
        expect(daily_weather_data).to_not have_key :moon_illumination
        expect(daily_weather_data).to_not have_key :is_moon_up
        expect(daily_weather_data).to_not have_key :is_sun_up
      end

      expect(weather_data[:attributes]).to have_key(:hourly_weather)
      expect(weather_data[:attributes][:hourly_weather]).to be_an Array

      hourly_weather_data = weather_data[:attributes][:hourly_weather]

      expect(hourly_weather_data.count).to eq(24)

      hourly_weather_data.each do |hour|
        expect(hourly_weather_data).to have_key :time
        expect(hourly_weather_data[:time]).to be_an String

        expect(hourly_weather_data).to have_key :temperature
        expect(hourly_weather_data[:temperature]).to be_an Float

        expect(hourly_weather_data).to have_key :condition
        expect(hourly_weather_data[:condition]).to be_an String

        expect(hourly_weather_data).to have_key :icon
        expect(hourly_weather_data[:icon]).to be_an Float

         #Check for attributes not passed for Weather API
         expect(hourly_weather_data).to_not have_key :time_epoch
         expect(hourly_weather_data).to_not have_key :temp_c
         expect(hourly_weather_data).to_not have_key :temp_f
         expect(hourly_weather_data).to_not have_key :is_day
         expect(hourly_weather_data).to_not have_key :text
         expect(hourly_weather_data).to_not have_key :code
         expect(hourly_weather_data).to_not have_key :wind_mph
         expect(hourly_weather_data).to_not have_key :wind_kph
         expect(hourly_weather_data).to_not have_key :wind_degree
         expect(hourly_weather_data).to_not have_key :wind_dir
         expect(hourly_weather_data).to_not have_key :pressure_mb
         expect(hourly_weather_data).to_not have_key :pressure_in
         expect(hourly_weather_data).to_not have_key :precip_mm
         expect(hourly_weather_data).to_not have_key :precip_in
         expect(hourly_weather_data).to_not have_key :humidity
         expect(hourly_weather_data).to_not have_key :cloud
         expect(hourly_weather_data).to_not have_key :feelslike_c
         expect(hourly_weather_data).to_not have_key :feelslike_m
         expect(hourly_weather_data).to_not have_key :windchill_c
         expect(hourly_weather_data).to_not have_key :windchil_f
         expect(hourly_weather_data).to_not have_key :heatindex_c
         expect(hourly_weather_data).to_not have_key :heatindex_f
         expect(hourly_weather_data).to_not have_key :dewpoint_c
         expect(hourly_weather_data).to_not have_key :dewpoint_f
         expect(hourly_weather_data).to_not have_key :will_it_rain
         expect(hourly_weather_data).to_not have_key :chance_of_rain
         expect(hourly_weather_data).to_not have_key :will_it_snow
         expect(hourly_weather_data).to_not have_key :chance_of_rain
         expect(hourly_weather_data).to_not have_key :will_it_snow
         expect(hourly_weather_data).to_not have_key :chance_of_snow
         expect(hourly_weather_data).to_not have_key :vis_km
         expect(hourly_weather_data).to_not have_key :vis_miles
         expect(hourly_weather_data).to_not have_key :gust_mph
         expect(hourly_weather_data).to_not have_key :gust_kph
         expect(hourly_weather_data).to_not have_key :uv
      end
    end
  end
end