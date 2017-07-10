class AddVarToMnpsReport < ActiveRecord::Migration[5.0]
  def change
    add_column :mnps_reports, :var, :integer
  end
end
