class BooksController < ApplicationController  
  before_filter :find_book_by_id
  
  
  
  private
  
  def find_book_by_id
    @book = Book.find params[:id]
  end
  
end
