class AppointmentsController < ApplicationController
	def new
		if params[:inviteId]
			@interest = Interest.find(params[:inviteId])
			unless @interest.nil?
				@appointment = Appointment.create(user_id: @interest.user_id, company_id: @interest.company_id, created_by_user: true)
		elsif params[:matchId] 
			@interest = Match.find(params[:matchId])		
			unless @interest.nil?
				@appointment = Appointment.create(user_id: @interest.user_id, company_id: @interest.company_id, created_by_user: false)
		end
		
		#@interest.destroy if @appointment


		if @appointment.created_by_user
	        user = User.find(@appointment.user_id)
	        if user.postcode.blank? || user.address_line_1.blank?
	          location = user.company
	        else
	          location = user
	        end
	    else
	        location = Company.find(@appointment.company_id)
	    end
		@event = Event.create(startsAt: build_start_at(params), title: build_title(), event_type: "warning", location: location.address_line_1.gsub(/\,/,"") + ', ' + (location.address_line_2.blank? ? '' : location.address_line_2.gsub(/\,/,"")+', ') + (location.address_line_3.blank? ? '' : location.address_line_3.gsub(/\,/,"") + ', ') + location.postcode.gsub(/\,/,"").upcase)
		@appointment.event = @event
		@appointment.save if @appointment
	end

	def build_title
		"Meeting with #{@holder.user.firstname} #{@holder.user.surname}"
	end

	def build_start_at(params)
		@time = "#{params[:time][:hours]}:#{params[:time][:minutes]}"
		date = params[:date].to_s.slice(/^\d+\-\d+\-\d+/)
		date = "#{date}T#{@time}"
	end

	def accept_appointment
		@appointment = Appointment.find(params[:_json])
		@appointment.accepted = true
		@appointment.save if @appointment

		@event = @appointment.event
		@event.event_type = "info"
		@event.save if @event
	end

	def company
		@company = User.find(params[:user][:id]).company
		@appointments = build_company_appointment_array

		render json: @appointments
	end

	def investor
		@user = User.find(params[:user][:id])
		@appointments = build_inv_appointment_array

		render json: @appointments
	end

	def build_company_appointment_array
		appointment_users = []
		@company.appointments.where(accepted: false).each do |x|
			appointment_users << [User.find(x.user_id), x.id]
		end
		appointment_users
	end

	def build_inv_appointment_array
		appointment_users = []
		@user.appointments.where(accepted: false).each do |x|
			appointment_users << [Company.find(x.company_id), x.id]
		end
		appointment_users
	end
end
