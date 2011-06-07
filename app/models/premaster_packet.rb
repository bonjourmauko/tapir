class PremasterPacket < ActiveRecord::Base
  
  validates :premaster_guid, :presence => true
  validates :position, :presence => true
  validates :client_timestamp, :presence => true
  validates :chunk, :presence => true
  
end