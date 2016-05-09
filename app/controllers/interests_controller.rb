class InterestsController < ApplicationController
	def show
		user_params = user_details
		@favourites = Array.new
		User.find(user_params[:id]).interests.each do |x|
		@favourites << Company.find(x.company_id)
		end
		render json: {favourites: @favourites}
	end

	def update
		user_params = user_favourites
		@user = User.find(user_params[:id])
		@user_id = @user.id
		@interests = User.find(user_params[:id]).interests
		if user_params[:add]
			user_params[:favourites].each do |x|
				Interest.create(user_id: @user_id, company_id: x)
				@friend_id = Company.find(x).users.find_by_contact_number(1)
				if @friend_id
					@friend_id = @friend_id.id
					Friendship.new(user_id: @user_id, friend_id: @friend_id, status: "accepted").save
					Friendship.new(user_id: @friend_id, friend_id: @user_id, status: "accepted").save
				end
			end
		else
			Interest.where(user_id: @user_id, company_id: user_params[:favourites]).delete_all
		end

		if @error
			render json: {error: true}
		end
	end

	def show_interested_in_me
		user_params = user_details
		@favourites = Array.new
		Company.find(User.find(user_params[:id]).company_id).interests.each do |x|
			user_x = User.find(x.user_id)
			@favourites << user_x.as_json
			@favourites.last[:company_name] = user_x.company.name
			if user_x.city.blank?
			  location = user_x.company
			else
			  location = user_x
			end
			@favourites.last[:city] = location.city
		end
		render json: {favourites: @favourites}
	end

	def user_details
  	params.require(:user).permit(:id)
	end

	def user_favourites
  	params.require(:user).permit(:id, :add, favourites: [])
	end

	def show_interested_companies
		@user = User.find(user_details[:id])
		@interested = build_interest_company_array

		render json: @interested
	end

	def show_interested_investors
		@company = User.find(user_details[:id]).company
		@interested = build_interest_investor_array

		render json: @interested
	end

	def delete_interest
		@interest = Interest.find(params[:invite][:id]) if params[:invite][:id]
		@interest.destroy if @interest

		render json: {status: 200}
	end

	def build_interest_investor_array
		interested_users = []
		@company.interests.each do |x|
			interested_users << [User.find(x.user_id), x.id]
		end
		interested_users
	end

	def build_interest_company_array
		interested_companies = []
		@user.interests.each do |x|
			interested_companies << [Company.find(x.company_id), x.id]
		end
		interested_companies
	end
end
