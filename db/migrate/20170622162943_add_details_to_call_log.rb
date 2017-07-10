class AddDetailsToCallLog < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :timesdialed, :integer
  end
end
