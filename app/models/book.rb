class Book < ActiveRecord::Base
  has_many :tags, through: :taggings
end
