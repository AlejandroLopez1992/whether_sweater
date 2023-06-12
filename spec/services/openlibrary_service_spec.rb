require 'rails_helper'

RSpec.describe OpenlibraryService do
  context "instance methods", :vcr do
    it "returns book objects based on title input" do
      search = OpenlibraryService.new("denver,co", 5).search
      expect(search).to be_a Hash
      expect(search).to have_key(:numFound)
      expect(search[:numFound]).to be_an Integer

      expect(search).to have_key(:docs)
      expect(search[:docs]).to be_an Array
      
      books = search[:docs]

      books.each do |book|
        expect(book).to have_key(:title)
        expect(book[:title]).to be_an String
        
        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an Array

        book[:isbn].each do |isbn|
          expect(isbn).to be_an String
        end

        expect(book).to have_key(:publisher)
        expect(book[:publisher]).to be_an Array

        book[:publisher].each do |publisher|
          expect(publisher).to be_an String
        end
      end
    end
  end
end
