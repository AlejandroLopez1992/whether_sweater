require 'rails_helper'

describe "User API" do
  describe "POST /api/v0/users" do
    it "provides weather data with 5 days of forcast" do

      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "email": "scoobydoo@yahoo.com"
        "password": "password",
        "password_confirmation": "password"
      }.to_json

      expect(User.all.count).to eq(0)

      get "/api/v0/users", headers: headers, body: body

      expect(response).to be_successful

      expect(response.status).to eq(201)

      expect(User.all.count).to eq(1)

      user = User.find_by(email: "scoobydoo@yahoo.com")

      expect(user.email).to eq("scoobydoo@yahoo.com")
      expect(user.password).to_not eq(nil)
      expect(user.api_key).to_not eq(nil)
    
      created_user_response = JSON.parse(response.body, symbolize_names: true)

      expect(created_user_response).to have_key(:data)
      expect(created_user_response[:data]).to be_an Hash 

      expect(created_user_response[:data]).to have_key(:type)
      expect(created_user_response[:data][:type]).to eq("users")

      expect(created_user_response[:data]).to have_key(:id)
      expect(created_user_response[:data][:id]).to be_an String

      expect(created_user_response[:data]).to have_key(:attributes)
      expect(created_user_response[:data][:attributes]).to be_an Hash

      expect(created_user_response[:data][:attributes]).to have_key(:email)
      expect(created_user_response[:data][:attributes][:email]).to be_an String

      expect(created_user_response[:data][:attributes]).to have_key(:api_key)
      expect(created_user_response[:data][:attributes][:api_key]).to be_an String

      expect(created_user_response[:data][:attributes]).to_not have_key(:password)
      expect(created_user_response[:data][:attributes]).to_not have_key(:password_digest)
    end
  end
end