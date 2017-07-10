class CreateTimeClocks < ActiveRecord::Migration[5.0]
  def change
    create_table :time_clocks do |t|
      t.time :clock_in
      t.time :clock_out
      t.date :date
      t.decimal :hours, precision: 8, scale: 3
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
