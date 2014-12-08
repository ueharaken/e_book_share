class AddColumnBooks < ActiveRecord::Migration
  def change
    add_column :books, :thumbnail, :binary, :limit => 10.megabyte, :null => false
  end
end
