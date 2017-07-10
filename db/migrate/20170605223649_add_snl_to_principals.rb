class AddSnlToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :snl_filename, :string
    add_column :principals, :snl_content_type, :string
    add_column :principals, :snl_contents, :binary
  end
end
