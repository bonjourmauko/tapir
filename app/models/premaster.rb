class Premaster < ActiveRecord::Base
  
  extend GuidMethods
  
  belongs_to :book
  before_validation :set_guid
  
  def build_from_packets packets
    
    body = ""
    packets.order('position ASC').each do |packet|
      body += packet.chunk
    end

    if self.upload_body body
      self.uploaded = true
      self.save
      packets.each do |packet| packet.destroy end
    else
      raise 'could not save the premaster in CloudFiles'
    end
    
    return true
    
  end
  
  
  def download_body
    raise 'No guid' if not guid
    premaster_container.object(guid).data    
  end
  
  def upload_body content
    raise 'No guid' if not guid
    premaster_container.create_object(guid).write content
  end
  
  def premaster_container
    container_name = 'premaster'
    get_or_create_container container_name
  end
  
  def get_or_create_container container_name
    cloudfiles_connection.container container_name
  rescue CloudFiles::Exception::NoSuchContainer
    cloudfiles_connection.create_container container_name
  end
  
  def cloudfiles_connection
    CloudFiles::Connection.new :username => "pictorical", :api_key => "e9a07c0f97594806e21f0f1deba3b34f"
  end
  
  private
  
  def set_guid
    self.guid = GuidMethods.new_guid if guid.nil?
  end
  
end
