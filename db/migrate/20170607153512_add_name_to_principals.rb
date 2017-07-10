class AddNameToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :schoolname, :string
  end
end
