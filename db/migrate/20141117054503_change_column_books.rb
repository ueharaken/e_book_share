class ChangeColumnBooks < ActiveRecord::Migration
  def change
    change_column :books, :author, :string
    change_column :books, :publisher, :string
  end
end
