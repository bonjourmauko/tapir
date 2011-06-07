class PremastersController < ApplicationController
  
def build
  
  number_of_packets = params[:number_of_packets].to_i
  premaster_guid = params[:premaster_id]
  timestamp = params[:timestamp]
  
  packets = PremasterPacket.where(:premaster_guid => premaster_guid, :client_timestamp => timestamp)
  raise 'did not receive all the packets' if packets.length != number_of_packets
  
  premaster = Premaster.find_by_guid(premaster_guid)
  raise 'did not find the premaster with guid #{premaster_guid}' if not premaster
  
  if premaster.build_from_packets packets
    render :text => "OK", :status => 200
    return
  else
    raise 'Could not build from packets'
  end
    
rescue => exc
  
  logger.error("Problem: #{exc.inspect} #{exc.message}")
  render :text => "Problem", :status => 500
  return
  
end
  
  
  
  
end
