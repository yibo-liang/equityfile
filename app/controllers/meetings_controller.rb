class MeetingsController << ActiveRecord::Base
	def new
		
		if meeting.save
			
		end
	end
	def show
		render Meeting.all.to_json
	end
end