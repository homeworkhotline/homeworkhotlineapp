class CreateCallLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :call_logs do |t|
      t.string :entered_by
      t.date :date
      t.time :starttime
      t.time :endtime
      t.integer :user_id
      t.boolean :math
      t.boolean :worksheet
      t.boolean :stoodle
      t.boolean :image_share
      t.string :textbook
      t.integer :page
      t.string :chaptitle
      t.string :notes
      t.string :skill
      t.integer :startknow
      t.integer :endknow
      t.string :codename

      t.timestamps
    end
  end
end
