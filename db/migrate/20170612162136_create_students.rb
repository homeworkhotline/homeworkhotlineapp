class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.integer :grade
      t.string :codename
      t.string :homelang
      t.boolean :internet
      t.integer :school_id

      t.timestamps
    end
  end
end
