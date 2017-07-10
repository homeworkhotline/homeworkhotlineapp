class AddNabToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :nab_filename, :string
    add_column :principals, :nab_content_type, :string
    add_column :principals, :nab_contents, :binary
  end
end
