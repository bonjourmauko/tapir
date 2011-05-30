class Illustration < ActiveRecord::Base
  belongs_to :book
  validates_uniqueness_of :external_id, :scope => :book_id
  before_validation :get_external_id
  before_create :set_content_type
  
  def get_external_id
    self.external_id = URI.parse(original_url).path.gsub('/','') if not external_id
  end
  
  def set_content_type
    self.content_type = get_content_type if not content_type
  end
  
  def get_content_type
    head = get_original_head
    raise 'Illustration response NOT 200' if head.class != Net::HTTPOK
    head['content-type']
  rescue
    nil
  end
  
  def get_original_head
    Net::HTTP.start original_uri.host, original_uri.port do |http|
      http.request_head original_uri.path
    end
  end
  
  def original_uri protocol = 'http'
    if protocol == 'http'
      URI.parse original_url_to_http
    else
      URI.parse original_url
    end
  end
  
  
  def original_url_to_http
    original_url.gsub('https://','http://')
  end
  
end