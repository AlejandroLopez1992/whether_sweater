class Books
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(destination, total_books_found)
    @id = nil
    @destination = destination
    @total_books_found = total_books_found
    @books = []
    @forecast = Hash.new
  end

  def organize_forecast(weather_data)
    @forecast[:summary] = weather_data[:current][:condition][:text]
    @forecast[:temperature] = weather_data[:current][:temp_f].to_s + " F"
  end

  def organize_books(books_data)
    books_data[:docs].each do |book|
      book_hash = Hash.new
      book_hash[:isbn] = book[:isbn]
      book_hash[:title] = book[:title]
      book_hash[:publisher] = book[:publisher]
      @books.push(book_hash)
    end
  end
end