class BooksSerializer
  include JSONAPI::Serializer
  attributes :total_books_found, :destination, :forecast, :books
end
