require 'rails_helper'

RSpec.describe RoadTrip do
  describe "RoadTrip object", :vcr do
    it 'exists' do
      road_trip = RoadTrip.new("New York, NY", "Los Angeles, CA")

      expect(road_trip).to be_an RoadTrip
      expect(road_trip.id).to eq(nil)
      expect(road_trip.start_city).to be_an String
      expect(road_trip.end_city).to be_an String
      expect(road_trip.travel_time).to eq(nil)
      expect(road_trip.weather_at_eta).to be_an Hash
    end

    it "weather_data method creates attributes within weather_at_eta Hash" do
      forecast = WeatherapiService.new("34.05357, -118.24545", 14).forecast

      forecast_hour = forecast[:forecast][:forecastday].first[:hour].first

      road_trip = RoadTrip.new("New York, NY", "Los Angeles, CA")

      expect(road_trip.weather_at_eta).to_not have_key :datetime
      expect(road_trip.weather_at_eta).to_not have_key :temperature
      expect(road_trip.weather_at_eta).to_not have_key :condition

      road_trip.weather_data(forecast_hour)

      expect(road_trip.weather_at_eta).to have_key :datetime
      expect(road_trip.weather_at_eta).to have_key :temperature
      expect(road_trip.weather_at_eta).to have_key :condition

      expect(road_trip.weather_at_eta[:datetime]).to eq(forecast_hour[:time])
      expect(road_trip.weather_at_eta[:temperature]).to eq(forecast_hour[:temp_f])
      expect(road_trip.weather_at_eta[:condition]).to eq(forecast_hour[:condition][:text])
    end
  end
end