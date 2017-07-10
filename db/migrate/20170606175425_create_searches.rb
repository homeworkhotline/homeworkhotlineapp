class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :model
      t.string :select
      t.string :search

      t.timestamps
    end
  end
end
