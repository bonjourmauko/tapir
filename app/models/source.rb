class Source < ActiveRecord::Base
  belongs_to :book
  
  def service
    @service or 'gdocs'
  end
  
  
  

  
end
