class AddMeetingsToPrincipals < ActiveRecord::Migration[5.0]
  def change
    add_column :principals, :mone, :datetime
    add_column :principals, :mtwo, :datetime
  end
end
