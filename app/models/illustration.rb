class Illustration < ActiveRecord::Base
  belongs_to :book
  validates_uniqueness_of :external_id, :scope => :book_id
  before_validation :get_external_id
  
  
  def get_external_id
    self.external_id = URI.parse(original_url).path.gsub('/','') if not external_id
  end
  
end
