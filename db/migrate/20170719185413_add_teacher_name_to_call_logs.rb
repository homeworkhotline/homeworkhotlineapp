class AddTeacherNameToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :teacher_name, :string
  end
end
