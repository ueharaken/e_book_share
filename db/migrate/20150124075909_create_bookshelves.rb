class CreateBookshelves < ActiveRecord::Migration
  def change
    create_table :bookshelves do |t|
      t.references :tag, index:true
      t.references :user, index:true
      t.timestamps
      t.index     [:user_id, :tag_id], unique: true
    end
  end
end
