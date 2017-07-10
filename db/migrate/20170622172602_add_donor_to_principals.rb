class AddDonorToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :d1, :string
    add_column :principals, :d2, :string
    add_column :principals, :d3, :string
  end
end
