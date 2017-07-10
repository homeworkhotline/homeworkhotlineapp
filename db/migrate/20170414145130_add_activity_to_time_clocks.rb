class AddActivityToTimeClocks < ActiveRecord::Migration[5.0]
  def change
    add_column :time_clocks, :activity, :string
  end
end
