class School < ApplicationRecord
	def next_school
    self.class.unscoped.first(:conditions => ["name > ?", name], :order => "name desc")
  end
end
