class SourcesController < ApplicationController
  
  def create
    
    user_email = params[:user_email]
    user_name = params[:user_name]
    gdocs_id = params[:GDocId]
    gdocs_type = params[:GDocType]
    gdocs_name = params[:GDocName]
    gdocs_language = params[:GDocLanguage]
    
    raise "no user_email" if not user_email
    raise "no gdocs_id" if not gdocs_id
    
  rescue => e
    
    render :text => e.message, :status => 400
    
  end
  
    
end
