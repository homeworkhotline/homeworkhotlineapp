class AddCorrectDurationToCallLogs < ActiveRecord::Migration[5.0]
  def change
  	remove_column :call_logs, :duration
    add_column :call_logs, :duration, :decimal, precision: 5, scale: 2
  end
end
