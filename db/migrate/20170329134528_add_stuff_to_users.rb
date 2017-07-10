class AddStuffToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :username, :string, unique: true
    add_column :users, :token, :string
    add_column :users, :role, :integer
  end
end
