class AddChecksToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :c1, :boolean
    add_column :principals, :c2, :boolean
    add_column :principals, :c3, :boolean
  end
end
