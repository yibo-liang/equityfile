class RegistersController < ApplicationController
  before_action :set_login, only: [:show, :update, :destroy]

  def add_user
    
  end

  def destroy
    @login.destroy

    head :no_content
  end

  private
    #def check_token
    #  unless ApiKey.exists?(access_token: params[:access_token])
    #    render json: {error: "401 You have not authenticated yourself..."} 
    #    head :status => 401
    #  end
    #end
end
