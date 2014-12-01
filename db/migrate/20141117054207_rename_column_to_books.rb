class RenameColumnToBooks < ActiveRecord::Migration
  def change
    rename_column :books, :author_id, :author
    rename_column :books, :publisher_id, :publisher
  end
end
