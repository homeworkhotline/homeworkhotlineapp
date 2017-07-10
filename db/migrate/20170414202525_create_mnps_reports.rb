class CreateMnpsReports < ActiveRecord::Migration[5.0]
  def change
    create_table :mnps_reports do |t|
      t.decimal :hours, precision: 8, scale: 3
      t.date :billdate
      t.integer :user_id

      t.timestamps
    end
  end
end
