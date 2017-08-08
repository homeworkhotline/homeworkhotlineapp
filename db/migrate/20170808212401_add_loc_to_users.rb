class AddLocToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :loc, :integer
  end
end
