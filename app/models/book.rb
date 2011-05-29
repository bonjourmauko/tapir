class Book < ActiveRecord::Base
  has_one :source
end
