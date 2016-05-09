class Appointment < ActiveRecord::Base
	belongs_to :user
	belongs_to :company
	has_one :event
end
