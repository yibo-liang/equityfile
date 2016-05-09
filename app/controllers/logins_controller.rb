class LoginsController < ApplicationController
  before_action :set_login, only: [:show, :update, :destroy]
  before_action :check_params_present, only: [:authenticate_user]

  def authenticate_user
    @user = User.authenticate(login_params)
    @token = ApiKey.create!
    
    if @user
      render json: {user_id: @user.id, email: @user.email, firstname: @user.firstname, surname: @user.surname, token: @token.access_token, userRole: @user.role, company_id: @user.company_id, company_name: @user.company.name, investor: @user.company.investor, accepted: @user.accepted, firstTime: @user.first_time}
    else
      render json: {error: "401 You have not authenticated yourself..."}
      head :status => 401
    end
  end

  private

    def set_login
      if params[:id].nil?
        @login = Login.find(params[:email]) 
      else
        render json: {error: "401 You have not authenticated yourself..."}
        head :status => 401
      end
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end
    def check_params_present
      if params.has_key?(:user)
        #allow to proceed
      else
        render json: {error: "401 You have not authenticated yourself..."}
        head :status => 401
      end
    end
end