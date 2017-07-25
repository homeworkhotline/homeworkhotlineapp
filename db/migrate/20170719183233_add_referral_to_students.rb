class AddReferralToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :reffered_by, :string
  end
end
