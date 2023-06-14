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

    it "if mapquestapi is unable to get directions for route because it's impossible, response is adjusted" do
      @user = User.create!(email: "scoobydoo@yahoo.com", password: "password", password_confirmation: "password", api_key: "2348u3")

      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "origin": "New York,NY",
        "destination": "London,UK",
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
      expect(road_trip_data[:data][:attributes][:end_city]).to eq("London, UK")

      expect(road_trip_data[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip_data[:data][:attributes][:travel_time]).to eq("impossible")

      expect(road_trip_data[:data][:attributes]).to have_key(:weather_at_eta)
      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to be_an Hash

      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to_not have_key(:datetime)
      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
      expect(road_trip_data[:data][:attributes][:weather_at_eta]).to_not have_key(:condition)
    end

    it "if api_key is not passed in or is incorrect, error with code 401 is sent" do
      @user = User.create!(email: "scoobydoo@yahoo.com", password: "password", password_confirmation: "password", api_key: "2348u3")

      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "origin": "New York,NY",
        "destination": "Los Angeles,CA"
      }.to_json

      post "/api/v0/road_trip", headers: headers, params: body

      expect(response).to_not be_successful

      expect(response.status).to eq(401)

      error_message = JSON.parse(response.body, symbolize_names: true)

      expect(error_message).to eq({
        errors: [
          {
            detail: "Request must contain api_key, if api_key was provided it may be incorrect",
          }
        ]}
      )

      headers2 = {"CONTENT_TYPE" => "application/json"}

      body2 = {
        "origin": "New York,NY",
        "destination": "Los Angeles,CA",
        "api_key": "2348455555555555u3"
      }.to_json

      post "/api/v0/road_trip", headers: headers2, params: body2

      expect(response).to_not be_successful

      expect(response.status).to eq(401)

      other_error_message = JSON.parse(response.body, symbolize_names: true)

      expect(other_error_message).to eq({
        errors: [
          {
            detail: "Request must contain api_key, if api_key was provided it may be incorrect",
          }
        ]}
      )
    end

    it "if origin or destination fields are missing, errors are sent with information on missing fields" do
      @user = User.create!(email: "scoobydoo@yahoo.com", password: "password", password_confirmation: "password", api_key: "2348u3")
      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "origin": "",
        "destination": "",
        "api_key": "2348u3"
      }.to_json

      post "/api/v0/road_trip", headers: headers, params: body

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      error_message_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_message_response).to eq({
        errors: [
          {
            detail: "Road Trip creation failed: Origin and Destination must be passed through in JSON payload through body of request"
          }
        ]
      }
      )
    end

    it "if params are not sent as raw JSON object in body, error is sent" do
      @user = User.create!(email: "scoobydoo@yahoo.com", password: "password", password_confirmation: "password", api_key: "2348u3")

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v0/road_trip?origin=Denver,CO&destination=New York, NY&api_key=2348u3", headers: headers

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      error_message_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_message_response).to eq({
        errors: [
          {
            detail: "Road Trip creation failed: Parameters must be sent in raw JSON payload within body of request"
          }
        ]
      }
      )
    end
  end
end