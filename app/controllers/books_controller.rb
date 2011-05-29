class BooksController < ApplicationController  
  before_filter :find_book_by_id
  
  
  def edit
    @source = @book.source
  end
  
  def update
    if @book.update_attributes params[:book]
      redirect_to marketing_book_path, :notice => 'Book was successfully updated.'
    else
      render :action => "edit"
    end
  end
  
  def marketing
  end
  
  def contents
    @source = @book.source
  end
  
  def premaster
    bookhtml = params[:bookhtml]
    @book.set_premaster bookhtml
    redirect_to marketing_book_path
  end
  
  
  
  private
  
  def find_book_by_id
    @book = Book.find params[:id]
  end
  
end
