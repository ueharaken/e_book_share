class AddTimestampsOnBooks < ActiveRecord::Migration
  def change
    change_table(:books) { |t| t.timestamps }
    change_table(:users) { |t| t.timestamps }
  end
end
