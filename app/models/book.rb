class Book < ActiveRecord::Base
  
  before_create :set_long_ids
  
  has_one :source
  belongs_to :user
  
  def set_premaster content
    raise 'No premaster_id' if not premaster_id
    premaster_container.create_object(premaster_id).write content
  end
  
  def premaster
    raise 'No premaster_id' if not premaster_id
    premaster_container.object(premaster_id).data    
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
  
  def send_xhtmls
    path = 'contents/section'
    extension = '.xhtml'
    epub_xhtmls.each_with_index do |xhtml, i|
      send_to_master :path => path + i.to_s + extension, :content => xhtml
    end
  end
  
  def send_to_master args
    
    raise 'No path set' if not args[:path]
    raise 'No content set' if not args[:content]
    
    master_container.create_object(args[:path]).write args[:content]
    logger.info args[:content].length.to_s + " bytes sent to " + args[:path]
    
  end


  
  def randid
    Digest::MD5.hexdigest(Time.now.to_s + rand(1000000000000000).to_s)
  end
  
  def set_long_ids
    self.premaster_id = randid
    self.master_id = randid
  end
  
  def premaster_container
    container_name = 'premaster'
    get_or_create_container container_name
  end

  def master_container format = "epub"
    container_name = 'master_' + master_id + '_' + format
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
  
  def chapters
    xhtml = premaster
    doc = Nokogiri::HTML::DocumentFragment.parse xhtml
    noko_chapters = doc.css('.chapter.level1')
    noko_chapters.collect do |chapter|
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
  
end
