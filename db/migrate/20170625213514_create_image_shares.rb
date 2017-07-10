class CreateImageShares < ActiveRecord::Migration[5.0]
  def change
    create_table :image_shares do |t|
      t.string :image_name
      t.string :image_type
      t.binary :image_content
      t.string :codename

      t.timestamps
    end
  end
end
