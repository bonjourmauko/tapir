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
    user = User.create! :email => user_email, :password => random_password unless user
    source = Source.create! :resource_id => resource_id, :service => 'google_docs'
    book = Book.create! :title => resource_title, :language => resource_lang
    book.source = source
    user.books << book
    
    render :text => "Created succesfully!\n", :status => 200
    
  rescue => e
    
    render :text => e.message + "\n", :status => 400
    
  end
  
  
  
  private
  
  def random_password
    Digest::MD5.hexdigest(Time.now.to_s + rand(100000).to_s)
  end
    
    
end
