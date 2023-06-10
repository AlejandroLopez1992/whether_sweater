require 'rails_helper'

RSpec.describe MapquestService do
  context "class methods", :vcr do
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
end
