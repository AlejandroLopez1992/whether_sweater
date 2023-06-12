class Api::V1::BooksSearchController < ApplicationController

  def show
    books = BooksFacade.new(params[:location], params[:quantity]).call_mapquest
    render json: BooksSerializer.new(books).serializable_hash.to_json, status: 200
  end
end