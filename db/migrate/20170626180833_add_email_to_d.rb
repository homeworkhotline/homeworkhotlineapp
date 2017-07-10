class AddEmailToD < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :de1, :string
    add_column :principals, :de2, :string
    add_column :principals, :de3, :string
  end
end
