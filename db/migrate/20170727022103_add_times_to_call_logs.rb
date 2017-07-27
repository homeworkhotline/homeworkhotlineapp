class AddTimesToCallLogs < ActiveRecord::Migration[5.0]
  def change
  	remove_column :call_logs, :starttime
    remove_column :call_logs, :endtime
    add_column :call_logs, :starttime, :datetime
    add_column :call_logs, :endtime, :datetime
  end
end
