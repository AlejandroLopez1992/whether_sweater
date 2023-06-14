require 'rails_helper'

RSpec.describe RoadTrip do
  describe "RoadTrip object", :vcr do
    it 'exists' do
      road_trip = RoadTrip.new("New York, NY", "Los Angeles, CA", "04:40:45")

      expect(road_trip).to be_an RoadTrip
      expect(road_trip.id).to eq(nil)
      expect(road_trip.start_city).to be_an String
      expect(road_trip.end_city).to be_an String
      expect(road_trip.travel_time).to be_an String
      expect(road_trip.weather_at_eta).to be_an Hash
    end
  end
end