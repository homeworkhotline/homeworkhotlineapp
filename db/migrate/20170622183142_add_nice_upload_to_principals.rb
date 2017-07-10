class AddNiceUploadToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :nice_name, :string
    add_column :principals, :nice_type, :string
    add_column :principals, :nice_content, :binary
  end
end
