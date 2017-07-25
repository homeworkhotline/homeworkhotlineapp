class AddPrizesToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :skillassessed, :text
    add_column :call_logs, :prize_given, :boolean
    add_column :call_logs, :name, :string
    add_column :call_logs, :prize_type, :string
    add_column :call_logs, :referral_prize, :boolean
  end
end
