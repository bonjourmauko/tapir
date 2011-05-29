class Book < ActiveRecord::Base
  has_one :source
  belongs_to :user
  
  def set_premaster content
    object = premaster_container.create_object(premaster_id).write content
  end
  
  def premaster
    object = premaster_container.object(premaster_id).data    
  end
  
  private
  
  def premaster_container
    container_name = 'pictorical_premaster'
    cf = CloudFiles::Connection.new :username => "pictorical", :api_key => "e9a07c0f97594806e21f0f1deba3b34f"
    container = cf.container container_name
  end
  
  
end
