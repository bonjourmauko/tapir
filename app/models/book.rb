class Book < ActiveRecord::Base
  has_one :source
  belongs_to :user
end
