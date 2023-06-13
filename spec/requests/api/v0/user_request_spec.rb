require 'rails_helper'

describe "User API" do
  describe "POST /api/v0/users" do
    it "allows for user registration and provides back json response with api key" do

      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "email": "scoobydoo@yahoo.com",
        "password": "password",
        "password_confirmation": "password"
      }.to_json

      expect(User.all.count).to eq(0)

      post "/api/v0/users", headers: headers, params: body

      expect(response).to be_successful

      expect(response.status).to eq(201)

      expect(User.all.count).to eq(1)

      user = User.find_by(email: "scoobydoo@yahoo.com")
      
      expect(user.email).to eq("scoobydoo@yahoo.com")
      expect(user.password_digest).to_not eq(nil)
      expect(user.api_key).to_not eq(nil)
    
      created_user_response = JSON.parse(response.body, symbolize_names: true)

      expect(created_user_response).to have_key(:data)
      expect(created_user_response[:data]).to be_an Hash 

      expect(created_user_response[:data]).to have_key(:type)
      expect(created_user_response[:data][:type]).to eq("user")

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

    it 'if user email input is already taken, error message is sent' do
      @user = User.create!(email: "scoobydoo@yahoo.com", password: "password", password_confirmation: "password", api_key: "2348u3")
      
      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "email": "scoobydoo@yahoo.com",
        "password": "password",
        "password_confirmation": "password"
      }.to_json

      expect(User.all.count).to eq(1)

      post "/api/v0/users", headers: headers, params: body

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      expect(User.all.count).to eq(1)

      error_message_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_message_response).to eq({
        errors: [
          {
            detail: "User creation failed: Email has already been taken"
          }
        ]
      }
      )
    end

    it "if passwords don't match error message is sent" do
      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "email": "scoobydoo@yahoo.com",
        "password": "password5644",
        "password_confirmation": "password"
      }.to_json

      expect(User.all.count).to eq(0)

      post "/api/v0/users", headers: headers, params: body

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      expect(User.all.count).to eq(0)

      error_message_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_message_response).to eq({
        errors: [
          {
            detail: "User creation failed: Password confirmation doesn't match Password"
          }
        ]
      }
      )
    end

    it "if any or all fields are missing, errors are sent with information on missing fields" do
      headers = {"CONTENT_TYPE" => "application/json"}

      body = {
        "email": "",
        "password": "",
        "password_confirmation": ""
      }.to_json

      expect(User.all.count).to eq(0)

      post "/api/v0/users", headers: headers, params: body

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      expect(User.all.count).to eq(0)

      error_message_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_message_response).to eq({
        errors: [
          {
            detail: "User creation failed: Email can't be blank, Password can't be blank, Password confirmation can't be blank"
          }
        ]
      }
      )
    end

    it "if params are not sent as raw JSON object in body or request/sent as standard params, error is sent" do

      headers = {"CONTENT_TYPE" => "application/json"}

      expect(User.all.count).to eq(0)

      post "/api/v0/users?email=person@woohoo.com&password=abc123&password_confirmation=abc123", headers: headers

      expect(User.all.count).to eq(0)

      expect(response).to_not be_successful

      expect(response.status).to eq(400)

      error_message_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_message_response).to eq({
        errors: [
          {
            detail: "User creation failed: Parameters must be send in raw JSON payload within body of request"
          }
        ]
      }
      )
    end
  end
end