class AddPrivateToSchools < ActiveRecord::Migration[5.0]
  def change
  	add_column :schools, :private, :boolean
  end
end
