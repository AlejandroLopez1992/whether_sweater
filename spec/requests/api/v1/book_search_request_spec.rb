require 'rails_helper'

describe "Books API" do
  describe "GET /api/v1/book-search?location=denver,co&quantity=5", :vcr do
    it "returns found books with title of city" do

      headers = {"CONTENT_TYPE" => "application/json"}


      get "/api/v1/book-search?location=denver,co&quantity=5", headers: headers

      expect(response).to be_successful

      books_data = JSON.parse(response.body, symbolize_names: true)

      expect(books_data[:data][:attributes][:books].count).to eq(5)

      expect(books_data[:data]).to have_key(:id)
      expect(books_data[:data][:id]).to eq(nil)

      expect(books_data[:data]).to have_key(:type)
      expect(books_data[:data][:type]).to eq("books")

      expect(books_data[:data]).to have_key(:attributes)
      expect(books_data[:data][:attributes]).to be_an Hash

      expect(books_data[:data][:attributes]).to have_key(:destination)
      expect(books_data[:data][:attributes][:destination]).to eq("denver,co")

      expect(books_data[:data][:attributes]).to have_key(:forecast)
      expect(books_data[:data][:attributes][:forecast]).to be_an Hash

      expect(books_data[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(books_data[:data][:attributes][:forecast][:summary]).to be_an String

      expect(books_data[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(books_data[:data][:attributes][:forecast][:temperature]).to be_an String

      expect(books_data[:data][:attributes]).to have_key(:total_books_found)
      expect(books_data[:data][:attributes][:total_books_found]).to be_an Integer

      expect(books_data[:data][:attributes]).to have_key(:books)
      expect(books_data[:data][:attributes][:books]).to be_an Array

      books_array = books_data[:data][:attributes][:books]

      expect(books_array.count).to eq(5)

      books_array.each do |book|
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an Array
        expect(book[:isbn].count).to eq(2)

        expect(book[:isbn].first).to be_an String
        expect(book[:isbn].second).to be_an String

        expect(book).to have_key(:title)
        expect(book[:title]).to be_an String

        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an Array
        book[:publisher].each do |publisher|
          expect(publisher).to be_an String
        end
      end
    end
  end
end





