class OpenlibraryService

  def initialize(title, limit)
    @title = title
    @limit = limit
  end

  def conn
    Faraday.new(url: "https://openlibrary.org") do |faraday|
      faraday.params["title"] = @title
      faraday.params["limit"] = @limit
    end
  end

  def search
    get_url("search.json")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end