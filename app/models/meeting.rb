class Meeting < ActiveRecord::Base

	belongs_to :user, class_name: "User"

	def meeting_times
		MeetingTime.where(meeting_id: self.id)
	end
end
