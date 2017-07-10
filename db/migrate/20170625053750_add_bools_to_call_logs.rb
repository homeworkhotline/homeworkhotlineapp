class AddBoolsToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :posttest, :boolean
    add_column :call_logs, :textbool, :boolean
  end
end
