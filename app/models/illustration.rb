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
    uri = URI.parse original_url_to_http
    head = nil
    Net::HTTP.start(uri.host, uri.port) do |http| head = http.request_head(uri.path) end
    raise 'Illustration response NOT 200' if head.class != Net::HTTPOK
    head['content-type']
  rescue
    nil
  end
  
  def original_url_to_http
    original_url.gsub('https://','http://')
  end
  
end