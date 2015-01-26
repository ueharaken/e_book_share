class AddTableUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :encrypted_password, null: false
    end
  end
end
