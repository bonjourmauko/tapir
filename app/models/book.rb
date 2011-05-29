class Book < ActiveRecord::Base
  has_one :source
  belongs_to :user
  
  before_validation :set_paypal_if_first_time
  
  
  def set_premaster content
    premaster_container.create_object(premaster_id).write content
  end
  
  def premaster
    premaster_container.object(premaster_id).data    
  end
  
  def use_this_paypal_username
    paypal_username or user.paypal_username
  end
  
  private
  
  def premaster_container
    container_name = 'pictorical_premaster'
    cf = CloudFiles::Connection.new :username => "pictorical", :api_key => "e9a07c0f97594806e21f0f1deba3b34f"
    container = cf.container container_name
  end
  
  def set_paypal_if_first_time
    if paypal_username and not user.paypal_username
        logger.info 'setting paypal_username for user'
        user.paypal_username = paypal_username
        user.save
        self.paypal_username = nil
    end
  end
  
  
end
