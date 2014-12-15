class Tag < ActiveRecord::Base
  has_many :books, through: :taggings
end
