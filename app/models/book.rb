class Book < ActiveRecord::Base
  scope :by_name, lambda {|name|
    if name.present?
      tokens = name.split(' ').map { |c| "%#{c}%" }
      if tokens.present?
        where((['( name like ? )']*tokens.size).join(' AND '),
          *tokens.map { |token| [token] * 1 }.flatten)
      end
    else
      {}
    end
  }

  scope :by_author, lambda {|author|
    if author.present?
      tokens = author.split(' ').map { |c| "%#{c}%" }
      if tokens.present?
        where((['( author like ? )']*tokens.size).join(' AND '),
          *tokens.map { |token| [token] * 1 }.flatten)
      end
    else
      {}
    end
  }

  scope :by_publisher, lambda {|publisher|
    if publisher.present?
      tokens = publisher.split(' ').map { |c| "%#{c}%" }
      if tokens.present?
        where((['( publisher like ? )']*tokens.size).join(' AND '),
          *tokens.map { |token| [token] * 1 }.flatten)
      end
    else
      {}
    end
  }

end
