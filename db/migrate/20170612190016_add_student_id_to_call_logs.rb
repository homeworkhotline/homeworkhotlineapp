class AddStudentIdToCallLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :call_logs, :student_id, :integer
  end
end
