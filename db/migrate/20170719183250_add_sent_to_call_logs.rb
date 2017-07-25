class AddSentToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :prize_sent, :boolean
  end
end
