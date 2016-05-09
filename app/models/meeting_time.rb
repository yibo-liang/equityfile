class MeetingTime < ActiveRecord::Base

	validates_presence_of :time
	belongs_to :meeting

end
