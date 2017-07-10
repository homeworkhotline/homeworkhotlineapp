class AddSchooltypeToSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :schooltype, :string
  end
end
