class AddForgottenToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :parent, :boolean
    add_column :call_logs, :lang, :string
    add_column :call_logs, :duration, :string
  end
end
