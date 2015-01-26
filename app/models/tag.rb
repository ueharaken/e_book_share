class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :books, through: :taggings
  has_many :bookshelves
  has_many :users, through: :bookshelves

  def self.del_space(name)
    name.gsub!(/[[:blank:]]/, '')
  end

end
