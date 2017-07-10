class AddReportIdToTimeClocks < ActiveRecord::Migration[5.0]
  def change
    add_column :time_clocks, :mnps_report_id, :integer
  end
end
