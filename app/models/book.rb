class Book < ActiveRecord::Base
  
  delegate :service, :to => :source
  
  after_create :create_premaster, :create_source, :create_master
  
  has_one :source
  has_one :premaster
  has_one :master
  belongs_to :user
  has_many :illustrations
  
  

  def extract_illustrations
    parsed_premaster.css('img').each do |image|
      original_url = image.attribute('src').value
      Illustration.find_or_create_by_book_id_and_original_url id, original_url
    end
  end

  def send_xmls
    send_to_master :path => "metadata.opf", :content => epub_opf
    send_to_master :path => "toc.ncx", :content => epub_ncx
    send_to_master :path => "mimetype", :content => EPUB_MIMETYPE
    send_to_master :path => "META-INF/container.xml", :content => EPUB_CONTAINERXML
  end
  
  def send_xhtmls
    path = 'contents/section'
    extension = '.xhtml'
    epub_xhtmls.each_with_index do |xhtml, i|
      send_to_master :path => path + i.to_s + extension, :content => xhtml
    end
  end

  def epub_opf
    apply_template EPUB_OPF_TEMPLATE, :title => title
  end

  def epub_ncx
    apply_template EPUB_NCX_TEMPLATE
  end
  
  def epub_xhtmls
    chapters.collect do |chapter|
      apply_template EPUB_XHTML_TEMPLATE, :body => chapter[:body], :title => chapter[:title] or "untitled"
    end
  end
  
  def parsed_premaster
    Nokogiri::HTML::DocumentFragment.parse premaster.body
  end



  def send_to_master args
    raise 'No path set' if not args[:path]
    raise 'No content set' if not args[:content]
    master_container.create_object(args[:path]).write args[:content]    
  end
  





  
  def cloudfiles_connection
    CloudFiles::Connection.new :username => "pictorical", :api_key => "e9a07c0f97594806e21f0f1deba3b34f"
  end
  
  def chapters
    parsed_premaster.css('.chapter.level1').collect do |chapter|
      {
        :title => chapter.css('h1').inner_html.strip,
        :body => chapter.inner_html
      }      
    end
  end
  
  def apply_template template = EPUB_XHTML_TEMPLATE, args = {}
    haml_engine = Haml::Engine.new template
    haml_engine.render Object.new, args
  end
  
  def create_premaster
    Premaster.create :book_id => id if @premaster.nil?
  end
  
  def create_source
    Source.create :book_id => id if @source.nil?
  end
  
  def create_master
    Master.create :book_id => id if @master.nil?
  end
  
end
