class CreatePrincipals < ActiveRecord::Migration[5.0]
  def change
    create_table :principals do |t|
      t.string :ccontactfirst
      t.string :ccontactlast
      t.string :ccontacttitle
      t.string :schoolsystem
      t.string :mailaddress
      t.string :csz
      t.string :phonenumb
      t.string :email
      t.string :textcontactfirst
      t.string :textcontactlast
      t.string :textcontactemail
      t.date :meetone
      t.date :meettwo
      t.string :completedbyfirst
      t.string :completedbylast
      t.string :completedbytitle
      t.string :schooltype
      t.integer :peds
      t.integer :census
      t.integer :ptgs
      t.boolean :sonicpartner
      t.boolean :titlei
      t.boolean :appalachain
      t.integer :districtnumb

      t.timestamps
    end
  end
end
