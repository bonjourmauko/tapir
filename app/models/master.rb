class Master < ActiveRecord::Base
  
  extend GuidMethods
  before_validation :set_guid
  belongs_to :book
  
  
  def master_container format = "epub"
    container_name = 'master_' + guid + '_' + format
    get_or_create_container container_name
  end
  
  def get_or_create_container container_name
    cloudfiles_connection.container container_name
  rescue CloudFiles::Exception::NoSuchContainer
    cloudfiles_connection.create_container container_name
  end
  
  
  
  private
  
  def set_guid
     self.guid = GuidMethods.new_guid if guid.nil?
  end
  
end
