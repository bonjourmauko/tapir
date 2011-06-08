class Image < ActiveRecord::Base
  belongs_to  :book
    
  has_attached_file :cover,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :bucket => 'tapir_covers',
                    :path => ":original_id/:style.:file_extension"
                    
end
