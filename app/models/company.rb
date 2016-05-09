class Company < ActiveRecord::Base
	has_many :users, dependent: :destroy
	validates_presence_of :name
	has_many :interests
	has_many :matches
	has_many :meetings, class_name: "Meeting"

	after_create do
		self.update(currency:"£")
  	end
end
