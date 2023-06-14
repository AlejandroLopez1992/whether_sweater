require 'rails_helper'

RSpec.describe MapquestService do
  context "instance methods", :vcr do
    describe "location" do
      it "location method returns latitude and longitude data" do
        search = MapquestService.new("Denver,CO").location
        expect(search).to be_a Hash
        expect(search[:results]).to be_an Array 
        search_data = search[:results].first 
  
        expect(search_data).to have_key :providedLocation
        expect(search_data[:providedLocation]).to be_an Hash
        expect(search_data[:providedLocation]).to have_key :location
  
        expect(search_data).to have_key :locations
        expect(search_data[:locations]).to be_an Array 
        expect(search_data[:locations].first).to have_key :latLng
  
        latlng = search_data[:locations].first[:latLng]
        expect(latlng).to be_an Hash 
        expect(latlng).to have_key :lat 
        expect(latlng).to have_key :lng
        expect(latlng[:lat]).to be_an Float 
        expect(latlng[:lng]).to be_an Float
      end
    end

    describe "directions" do
      it "direction method returns time and formatted time data" do
        search = MapquestService.new("Los Angeles, CA", "New York,NY").directions
        expect(search).to be_a Hash

        expect(search).to have_key(:route)
        expect(search[:route]).to be_an Hash

        route_data = search[:route]
  
        expect(route_data).to have_key :time
        expect(route_data[:time]).to be_an Integer

        expect(route_data).to have_key :formattedTime
        expect(route_data[:formattedTime]).to be_an String

        expect(route_data).to have_key :legs
        expect(route_data[:legs]).to be_an Array

        expect(route_data[:legs].first).to be_an Hash
        expect(route_data[:legs].first).to have_key(:time)
        expect(route_data[:legs].first[:time]).to be_an Integer

        expect(route_data[:legs].first).to have_key(:formattedTime)
        expect(route_data[:legs].first[:formattedTime]).to be_an String
      end
    end
  end
end
