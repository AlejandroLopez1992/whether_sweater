require 'rails_helper'

RSpec.describe WeatherObject do
  it 'exists', :vcr do
    attrs = WeatherapiService.new("39.74001,-104.99202", 5)
    
    weather_object = WeatherObject.new(attrs)

    expect(weather_object).to be_a WeatherObject
    expect(weather_object.id).to eq(nil)
    expect(weather_object.current_weather).to be_an Hash

    expect(weather_object.current_weather[:last_updated]).to be_an "String"
    expect(weather_object.last_updated)
  end