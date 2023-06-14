require 'rails_helper'

describe "Road Trip API" do
  describe "POST /api/v0/road_trip", :vcr do
    it "provides road trip information including travel time and weather at ETA based on passed starting and ending city" do
      @user = User.create!(email: "scoobydoo@yahoo.com", password: "password", password_confirmation: "password", api_key: "2348u3")

      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "origin": "New York,NY",
        "destination": "Los Angeles,CA",
        "api_key": "2348u3"
      }.to_json

      post "/api/v0/road_trip", headers: headers, params: body

      expect(response).to be_successful

      expect(response.status).to eq(200)

      road_trip_data = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip_data).to have_key(:data)
      expect(road_trip_data[:data]).to be_an Hash

      expect(road_trip_data[:data]).to have_key(:id)
      expect(road_trip_data[:data][:id]).to eq(nil)

      expect(road_trip_data[:data]).to have_key(:type)
      expect(road_trip_data[:data][:type]).to eq("road_trip")

      expect(road_trip_data[:data]).to have_key(:attributes)
      expect(road_trip_data[:data][:attributes]).to be_an Hash

      expect(road_trip_data[:data][:attributes]).to have_key(:start_city)
      expect(road_trip_data[:data][:attributes][:start_city]).to eq("New York, NY")

      expect(road_trip_data[:data][:attributes]).to have_key(:end_city)
      expect(road_trip_data[:data][:attributes][:end_city]).to eq("Los Angeles, CA")

      expect(road_trip_data[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip_data[:data][:attributes][:travel_time]).to be_an String

      expect(road_trip_data[:data][:attributes]).to have_key(:weather_at_eta)
      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to be_an Hash

      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(road_trip_data[:data][:attributes][:weather_at_eta][:datetime]).to be_an String

      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip_data[:data][:attributes][:weather_at_eta][:temperature]).to be_an Float 

      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(road_trip_data[:data][:attributes][:weather_at_eta][:condition]).to be_an String
    end
  end
end