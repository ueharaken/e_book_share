class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.integer :author_id
      t.integer :publisher_id
      t.integer :category_id
      t.integer :price
    end
  end
end
