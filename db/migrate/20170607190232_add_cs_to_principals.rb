class AddCsToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :city, :string
    add_column :principals, :zip, :integer
  end
end
