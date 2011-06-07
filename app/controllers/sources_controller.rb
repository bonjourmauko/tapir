class SourcesController < ApplicationController
  
  def create
    
    user_email = params[:user_email]
    user_name = params[:user_name]
    resource_id = params[:resource_id]
    resource_type = params[:resource_type]
    resource_title = params[:resource_title]
    resource_lang = params[:resource_lang]
    
    raise "No user_email" if not user_email
    raise "No resource_id" if not resource_id
    
    user = User.find_by_email user_email
    user = User.new :email => user_email unless user
    source = Source.new :resource_id => resource_id, :service => 'google_docs'
    book = Book.new :title => resource_title, :language => resource_lang
    book.source = source
    user.books << book
    
    raise "User record is invalid" if not user.valid? and user.new_record?
    raise "Book record is invalid" if not book.valid?
    raise "Source record is invalid" if not source.valid?
    
    user.save! if user.new_record?
    source.save!
    book.save!

    Transactional.welcome(book).deliver

    render :text => "Created succesfully!\n", :status => 200
    
  rescue => exc
    
    logger.error "Problem #{exc.inspect}: #{exc.message}"
    render :text => "Error" + "\n", :status => 400
    
  end
  
    
    
end
