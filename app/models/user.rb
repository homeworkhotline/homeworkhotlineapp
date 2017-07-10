class User < ApplicationRecord

  has_many :time_clocks
  has_many :mnps_reports
  has_many :call_logs

	validates :token,
    inclusion: { in: [ "volunteer" , "hotline teacher", "reading teacher", "math teacher", "mnps","5h43bf3ff2azce43", "ghr4 th43 greh 4u5j rbre 3tgr j3nr 97md"] }

  validates :username, :firstname, :lastname, :email, :token,
    presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:student_volunteer, :hotline_teacher, :beat_math_teacher, :call_it_reading_teacher, :mnps_teacher, :administrator, :developer]


end
