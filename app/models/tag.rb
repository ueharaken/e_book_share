class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :books, through: :taggings

  def self.del_space(name)
    name.gsub!(/[[:blank:]]/, '')
  end

end
