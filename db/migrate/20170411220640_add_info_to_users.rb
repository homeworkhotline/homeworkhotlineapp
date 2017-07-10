class AddInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :district, :string
    add_column :users, :men, :integer
    add_column :users, :school, :string
    add_column :users, :program, :string
    add_column :users, :locationcode, :integer
  end
end
