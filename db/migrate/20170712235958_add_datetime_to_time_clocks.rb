class AddDatetimeToTimeClocks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :time_clocks, :clock_out, :time
    remove_column :time_clocks, :clock_in, :time
    add_column :time_clocks, :clock_in, :datetime
    add_column :time_clocks, :clock_out, :datetime
  end
end
