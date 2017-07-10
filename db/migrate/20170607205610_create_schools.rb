class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :county
      t.string :phone
      t.string :principal
      t.string :principalemail
      t.boolean :sonic
      t.integer :peds
      t.integer :census
      t.integer :ptgs
      t.boolean :appalreg
      t.boolean :titlei
      t.integer :sbdistrict
      t.integer :ccdistrict

      t.timestamps
    end
  end
end
