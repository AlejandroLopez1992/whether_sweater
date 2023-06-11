require 'rails_helper'

describe "Forecast API" do
  describe "GET /api/v0/forecast?location=city,state", :vcr do
    it "provides weather data with 5 days of forcast" do

      headers = {"CONTENT_TYPE" => "application/json"}


      get "/api/v0/forecast?location=cincinatti,oh", headers: headers

      expect(response).to be_successful

      weather_data = JSON.parse(response.body, symbolize_names: true)

      expect(weather_data.count).to eq(1)


      expect(weather_data[:data]).to have_key(:id)
      expect(weather_data[:data][:id]).to eq(nil)

      expect(weather_data[:data]).to have_key(:type)
      expect(weather_data[:data][:type]).to eq("forecast")

      expect(weather_data[:data]).to have_key(:attributes)
      expect(weather_data[:data][:attributes]).to be_an Hash

      expect(weather_data[:data][:attributes]).to have_key(:current_weather)
      expect(weather_data[:data][:attributes][:current_weather]).to be_an Hash

      current_weather_data = weather_data[:data][:attributes][:current_weather]

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

      expect(weather_data[:data][:attributes]).to have_key(:daily_weather)
      expect(weather_data[:data][:attributes][:daily_weather]).to be_an Array

      daily_weather_data = weather_data[:data][:attributes][:daily_weather]

      expect(daily_weather_data.count).to eq(5)

      daily_weather_data.each do |day|
        expect(day).to have_key :date
        expect(day[:date]).to be_an String

        expect(day).to have_key :sunrise
        expect(day[:sunrise]).to be_an String

        expect(day).to have_key :sunset
        expect(day[:sunset]).to be_an String

        expect(day).to have_key :max_temp
        expect(day[:max_temp]).to be_an Float

        expect(day).to have_key :min_temp
        expect(day[:min_temp]).to be_an Float

        expect(day).to have_key :condition
        expect(day[:condition]).to be_an String

        expect(day).to have_key :icon
        expect(day[:icon]).to be_an String

         #Check for attributes not passed for Weather API
        expect(day).to_not have_key :date_epoch
        expect(day).to_not have_key :maxtemp_c
        expect(day).to_not have_key :maxtemp_f
        expect(day).to_not have_key :mintemp_c
        expect(day).to_not have_key :mintemp_f
        expect(day).to_not have_key :avgtemp_c
        expect(day).to_not have_key :avgtemp_f
        expect(day).to_not have_key :maxwind_mph
        expect(day).to_not have_key :maxwind_kph
        expect(day).to_not have_key :totalprecip_mm
        expect(day).to_not have_key :totalprecip_in
        expect(day).to_not have_key :totalsnow_cm
        expect(day).to_not have_key :avgvis_km
        expect(day).to_not have_key :avgis_miles
        expect(day).to_not have_key :avghumidity
        expect(day).to_not have_key :daily_will_it_rain
        expect(day).to_not have_key :daily_chance_of_rain
        expect(day).to_not have_key :daily_will_it_snow
        expect(day).to_not have_key :daily_chance_of_snow
        expect(day).to_not have_key :text
        expect(day).to_not have_key :code
        expect(day).to_not have_key :uv
        expect(day).to_not have_key :astro
        expect(day).to_not have_key :moonrise
        expect(day).to_not have_key :moonset
        expect(day).to_not have_key :moon_phast
        expect(day).to_not have_key :moon_illumination
        expect(day).to_not have_key :is_moon_up
        expect(day).to_not have_key :is_sun_up
      end

      expect(weather_data[:data][:attributes]).to have_key(:hourly_weather)
      expect(weather_data[:data][:attributes][:hourly_weather]).to be_an Array

      hourly_weather_data = weather_data[:data][:attributes][:hourly_weather]

      expect(hourly_weather_data.count).to eq(24)

      hourly_weather_data.each do |hour|
        expect(hour).to have_key :time
        expect(hour[:time]).to be_an String

        expect(hour).to have_key :temperature
        expect(hour[:temperature]).to be_an Float

        expect(hour).to have_key :condition
        expect(hour[:condition]).to be_an String

        expect(hour).to have_key :icon
        expect(hour[:icon]).to be_an String

         #Check for attributes not passed for Weather API
         expect(hour).to_not have_key :time_epoch
         expect(hour).to_not have_key :temp_c
         expect(hour).to_not have_key :temp_f
         expect(hour).to_not have_key :is_day
         expect(hour).to_not have_key :text
         expect(hour).to_not have_key :code
         expect(hour).to_not have_key :wind_mph
         expect(hour).to_not have_key :wind_kph
         expect(hour).to_not have_key :wind_degree
         expect(hour).to_not have_key :wind_dir
         expect(hour).to_not have_key :pressure_mb
         expect(hour).to_not have_key :pressure_in
         expect(hour).to_not have_key :precip_mm
         expect(hour).to_not have_key :precip_in
         expect(hour).to_not have_key :humidity
         expect(hour).to_not have_key :cloud
         expect(hour).to_not have_key :feelslike_c
         expect(hour).to_not have_key :feelslike_m
         expect(hour).to_not have_key :windchill_c
         expect(hour).to_not have_key :windchil_f
         expect(hour).to_not have_key :heatindex_c
         expect(hour).to_not have_key :heatindex_f
         expect(hour).to_not have_key :dewpoint_c
         expect(hour).to_not have_key :dewpoint_f
         expect(hour).to_not have_key :will_it_rain
         expect(hour).to_not have_key :chance_of_rain
         expect(hour).to_not have_key :will_it_snow
         expect(hour).to_not have_key :chance_of_rain
         expect(hour).to_not have_key :will_it_snow
         expect(hour).to_not have_key :chance_of_snow
         expect(hour).to_not have_key :vis_km
         expect(hour).to_not have_key :vis_miles
         expect(hour).to_not have_key :gust_mph
         expect(hour).to_not have_key :gust_kph
         expect(hour).to_not have_key :uv
      end
    end
  end
end