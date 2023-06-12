require 'rails_helper'

RSpec.describe Books do
  describe "Books Object", :vcr do
    it 'exists' do
      books = Books.new("denver, co", 43)

      expect(books).to be_an Books
      expect(books.id).to eq(nil)
      expect(books.destination).to be_an String
      expect(books.forecast).to be_an Hash
      expect(books.total_books_found).to be_an Integer
      expect(books.books).to be_an Array
    end

    it "organize_forecast methods creates key/value pairs for forecast attribute" do

      attrs = WeatherapiService.new("39.74001,-104.99202", 5).forecast
      books = Books.new("denver, co", 43)

      expect(books.forecast).to_not have_key(:summary)
      expect(books.forecast).to_not have_key(:temperature)

      books.organize_forecast(attrs)

      expect(books.forecast).to have_key(:summary)
      expect(books.forecast[:summary]).to be_an String

      expect(books.forecast).to have_key(:temperature)
      expect(books.forecast[:temperature]).to be_an String
    end
  end 
end 