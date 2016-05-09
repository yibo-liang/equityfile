class MeetingInstance < ActiveRecord::Base
	belongs_to :meeting, class_name: "Meeting"
	belongs_to :user, class_name: "User"
	has_one :meeting_time, class_name: "MeetingTime", dependent: :nullify


end
