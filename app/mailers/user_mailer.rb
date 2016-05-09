class UserMailer < ApplicationMailer
	default from: 'noreply@equityfile.com'

	def welcome_email(user, pass)
	@user = user
	@random_password = pass
	mail(to: @user.email, subject: 'Welcome to EquityFile')
	end

	def fail_email(reason, user)
	@user = user
	@reason = reason
	mail(to: @user.email, subject: 'Sorry your registration to EquityFile failed')
	end

	def invite_email(message_text, email, who)
		@message = ActionController::Base.helpers.strip_tags(message_text)
		@who = who
		mail(to: email, subject: 'You have received an invite to EquityFile')
	end

	def code_email(email, code)
		@code = code
		mail(to: email, subject: 'Forgotten password on EquityFile')
	end

	def not_activated_email(email)
		mail(to: email, subject: 'EquityFile account not yet approved')
	end
end
