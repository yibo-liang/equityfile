class EventsController < ApplicationController
	before_action :set_user, only: [:index, :show]

	def index
		if params[:investor]
			render json: @user.events
		else
			render json: @user.company.events
		end
	end

	private
		def set_user
			@user = User.find(params[:id])
		end
end
