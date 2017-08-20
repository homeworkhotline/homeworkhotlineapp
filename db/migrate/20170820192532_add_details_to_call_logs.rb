class AddDetailsToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :dropped, :boolean
    add_column :call_logs, :transferred, :boolean
    add_column :call_logs, :chat, :boolean
  end
end
