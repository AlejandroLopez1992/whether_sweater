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

    it "organize_books method creates book hash objects and key/value pairs for them" do

      attrs = OpenlibraryService.new("denver, co", 5).search
      books = Books.new("denver, co", 43)

      expect(books.books.count).to eq(0)
   
      books.organize_books(attrs)

      expect(books.books.count).to eq(5)

      books.books.each do |book|
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an Array
        expect(book[:isbn].first).to be_an String
        expect(book[:isbn].second).to be_an String

        expect(book).to have_key(:title)
        expect(book[:title]).to be_an String

        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an Array
        expect(book[:publisher].first).to be_an String
      end
    end
  end 
end 