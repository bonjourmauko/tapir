class BooksController < ApplicationController  
  before_filter :find_book_by_id, :except => [:premaster]
  before_filter :get_action_name
  
  
  def edit
    @source = @book.source
  end
  
  
  
  def update
    last = params[:last_action] or 'contents'
    
    if @book.update_attributes params[:book]
      redirect_to :action => next_action(last)#, :notice => 'Book was successfully updated.'
    else
      render :action => last
    end
  end
  
  
  
  def marketing
  end
  
  def contents
    @source = @book.source
    @premaster = @book.premaster
  end
  
  def publish
  end
  
  
  def epub_opf
    render 'books/epub/metadata.opf'
  end


  
  private
  
  def find_book_by_id
    @book = Book.find params[:id]
  end
  
  def get_action_name
    @action = params[:action]
  end
  
  def next_action current
    order = ['contents','marketing','publish']
    index = order.index current
    if index then order.slice index + 1 else order.last end
  end
  
end
