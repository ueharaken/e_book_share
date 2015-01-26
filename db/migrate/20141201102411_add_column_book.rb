class AddColumnBook < ActiveRecord::Migration
  def chang
    add_column :books, :path, :string, :null => false
  end
end
