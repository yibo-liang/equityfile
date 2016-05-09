class MatchesController < ApplicationController
	def show
		company_params = company_details
		@matches = Array.new
		Company.find(company_params[:id]).matches.each do |x|
			user_x = User.select("firstname, surname, company_id, id, city").find(x.user_id)
			@matches << user_x.as_json
			@matches.last[:company_name] = user_x.company.name
			if user_x.city.blank?
			  location = user_x.company
			else
			  location = user_x
			end
			@matches.last[:city] = location.city
		end
		render json: {matches: @matches}
	end

	def update
		company_params = company_favourites
		puts company_params[:id]
		@company = Company.find(company_params[:id])
		@company_id = @company.id
		if company_params[:add]
			company_params[:matches].each do |x|
				Match.create(company_id: @company_id, user_id: x)
			end
		else
			Match.where(company_id: @company_id, user_id: company_params[:matches]).delete_all
		end

		if @error
			render json: {error: true}
		end
	end

	def company_details
  	params.require(:company).permit(:id)
	end

	def company_favourites
  	params.require(:company).permit(:id, :add, matches: [])
	end

	def show_interested_investors
		@company = Company.find(company_details[:id])
		@interested = build_interest_array

		render json: @interested
	end

	def build_interest_array
		interested_users = []
		@company.matches.each do |x|
			interested_users << [User.find(x.user_id), x.id]
		end
		interested_users
	end
end
