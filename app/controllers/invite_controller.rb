class InviteController < ApplicationController

	def send_emails
		invite_params = params.require(:invite).permit(:emails, :message, :who)
		@errors = Array.new
		if invite_params[:message].nil? || invite_params[:message].eql?("")
        	@errors[2] = true
      	end

      	if invite_params[:emails].nil? || invite_params[:message].eql?("")
        	@errors[1] = true
      	else
			@emails = invite_params[:emails].gsub(/\s+/, "").split(";").uniq.compact
			if !@emails.any?
        		@errors[1] = true
      		end
		end


		if @errors.any?
			@errors[0] = true
        	render json: {success: false, error: @errors}
        else
        	render json: {success: true}
			@emails.each do |email|
				UserMailer.invite_email(invite_params[:message], email, invite_params[:who]).deliver_now
			end
		end
	end

end
