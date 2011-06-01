class SourcesController < ApplicationController
  
  def create
    
    user_email = params[:user_email]
    user_name = params[:user_name]
    resource_id = params[:resource_id]
    resource_type = params[:resource_type]
    resource_title = params[:resource_title]
    resource_lang = params[:resource_lang]
    
    raise "no user_email" if not user_email
    raise "no resource_id" if not resource_id
    
    Source.create :resource_id => resource_id
    User.create :email => user_email, :password => "walwalalalalskksksksksksksksk"
    
    render :text => "Created succesfully!", :status => 200
    
  rescue => e
    
    render :text => e.message, :status => 400
    
  end
  
    
end
