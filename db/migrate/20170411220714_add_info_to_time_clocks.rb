class AddInfoToTimeClocks < ActiveRecord::Migration[5.0]
  def change
    add_column :time_clocks, :billed, :boolean
  end
end
