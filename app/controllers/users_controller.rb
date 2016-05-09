class UsersController < ApplicationController
  def index
    @users = User.all
    puts @users.to_json
    render json: @users, :except=>  [:password_hash, :password_salt]
  end
  def friends
    @friends = get_friends
    unless @friends.nil?
      puts @friends.to_json
      render json: @friends
    else
      head :status => 401
      render json: "{error : \"401 not authenticated\"}"
    end
  end
  def destroy
    if User.find(params[:user_id]).destroy
      render json: {success: "User destroyed successfully..."}
    else
      render json: {error: "Problem destroying user..."}
    end
  end
  def create
    user_params = user_details
    company_params = company_details

    #Display sent data in the console of the server
    #puts "User Paramaters Passed: \n" + user_params.to_s + "\n\n"
    #puts "Company Paramaters Passed: \n" + company_params.to_s + "\n\n"
    #puts "Position Paramaters Passed: \n" + position_params.to_s + "\n\n"

    if user_params.has_key?(:firstname) && user_params.has_key?(:surname) && user_params.has_key?(:email) && user_params.has_key?(:position) && company_params.has_key?(:name) && company_params["address"].has_key?(:country) && company_params["address"].has_key?(:line1) && company_params["address"].has_key?(:postcode) && company_params["address"].has_key?(:city) && user_params.has_key?(:telephone) && company_params["address"].has_key?(:lat) && company_params["address"].has_key?(:lng)

      @errors = Array.new


      @errors = Array.new

        @errors[1] = User.exists?(:email => user_params[:email])
        @errors[5] = !company_params[:symbol].blank? && Company.exists?(:symbol => company_params[:symbol].upcase) 
        @errors[2] = /^[A-z]+$/.match(user_params[:firstname]) == nil
        @errors[3] = /^[A-z]+$/.match(user_params[:surname]) == nil

      if @errors.any?
        render json: {success: false, error: @errors}

      else

        if Company.exists?(:name => company_params[:name])
          @company = Company.find_by_name(company_params[:name])
        else
          @company = Company.new(name: company_params[:name], investor: company_params[:investor], country: company_params[:address][:country][:country], address_line_1: company_params[:address][:line1], postcode: company_params[:address][:postcode], city: company_params[:address][:city], lat: company_params[:address][:lat], lng: company_params[:address][:lng])
        end

        if !@company.errors.any?
          if company_params[:investor]
          @user = @company.users.new(firstname: user_params[:firstname],surname: user_params[:surname],email: user_params[:email],position: user_params[:position][:title], contact_number: @company.users.count+1, telephone: user_params[:telephone])
          else
          @user = @company.users.new(firstname: user_params[:firstname],surname: user_params[:surname],email: user_params[:email],position: params[:user][:position], contact_number: @company.users.count+1, telephone: user_params[:telephone])
          end
          if @company.address_line_1.blank?
            @company.address_line_1 = company_params[:address][:line1]
            @company.country = company_params[:address][:country][:country]
            @company.postcode = company_params[:address][:postcode]
            @company.city = company_params[:address][:city]
            @company.lat = company_params[:address][:lat]
            @company.lng = company_params[:address][:lng]
          end

          if @company.save && @user.save
            render json: {success: true}
          else
            render json: {success: false, unknown: true}
            @company.destroy
            @user.destroy
          end
        end
      end

    else
      render json: {success: false, error_message: "There was an unknown issue with one of the entered fields please check you have completed this form and try again"}
    end



  end

  def show
    @user = User.find(params[:id])
    if !@user.nil?
      puts @user.to_json
      render json: @user, :except=>  [:password_hash, :password_salt]
    end
  end

  def additional_details
    @info = User.find(params[:id]).additional_detail
    if !@info.nil?
      render json: @info
    end
  end

  def additional_details_update
    @info = AdditionalDetail.find_by(user_id: params[:id])
    details_params = additional_details_params
    @errors = []

    if (defined? details_params[:assets]) && /\A[+]?[0-9]+(\.[0-9][0-9]?)?\z/.match(details_params[:assets].to_s) == nil
        @errors[1] = true
      else
        @info.update_attribute(:assets, details_params[:assets])
    end

    if @errors.any?
      @errors[0] = true
      render json: {success: false, error: @errors}
    else
      if @info.update(details_params.except(:assets))
        render json: {success: true}
      else
        render json: {success: false}
      end
    end
  end

  def show_from_company
    @users = User.where(company_id: params[:company_id])
    render json: @users, :except=>  [:password_hash, :password_salt]
  end

  def search
    @users = get_users
    #Display data in console
    puts @users.to_json
    render json: @users.order(email: :asc)
  end

  def user_details
    params.require(:user).permit(:firstname, :surname, :email, :password, :telephone, :postcode, :address_line_1, :address_line_2, :address_line_3, :city, :contact,:position ,:lat, :lng, position: [:title, :state], country: [:country])
  end
  def company_details
    params.require(:company).permit(:name, :symbol, :investor, address: [:lat, :lng, :line1, :line2, :line3, :postcode, :city, country: [:country]])
  end

  def additional_details_params
    params.require(:details).permit(:aerospace_defense, :alternative_energy, :automobiles_parts, :banks, :beverages, :chemicals, :construction_materials, :electricity, :electronic_electrical_equipment, :equity_investment_instruments, :financial_services, :fixed_line_telecommunications, :food_drug_retailers, :food_producers, :forestry_paper, :gas_water_multiutilities, :general_industrials, :general_retailers, :health_care_equipment_services, :household_goods_home_construction, :industrial_engineering, :industrial_metals_mining, :industrial_transportation, :leisure_goods, :life_insurance, :media, :mining, :mobile_telecommunications, :nonequity_investment_instruments, :nonlife_insurance, :oil_gas_producers, :oil_equipment_services_distribution, :personal_goods, :pharmaceuticals_biotechnology, :real_estate_investment_services, :real_estate_investment_trusts, :software_computer_services, :support_services, :technology_hardware_equipment, :tobacco, :travel_leisure, :growth, :value, :income, :garp, :contrarian, :momentum, :user_id, :assets,)
  end
  def get_friends
    unless params[:user_id].blank?
        User.find(params[:user_id]).friends
    end
  end    
  def position_details(position)
    unless position.nil?
      case position.downcase
      when "analyst"
        params.require(:analyst).permit(:companyAssets, :equityAssets, :ukEquityAssets, industries: [:forestryPaper, :leisureGoods, :industrialMetalsMining, :travelLeisure])
      when "portfolioManager"
        params.require(:portfolioManager).permit(:companyAssets, :equityAssets, :ukEquityAssets, stylebias: [])
      when "teamAssistant"
        params.require(:teamAssistant)
        .permit(:oneFirstName, 
                :oneLastName, 
                :oneEmail, 
                onePosition: [:title, :state],
                )
      end
    else
      #puts "You didn't give me a position..."
      render json: "{error : \"Bad position data...\"}"
    end
  end

  def update
    user_params = user_details
    if User.exists?(params[:id])
      @errors = Array.new

      @user = User.find(params[:id])

        @errors[1] = /^[0-9]+$/.match(user_params[:telephone]) == nil && !user_params[:telephone].blank?
        @errors[2] = /^[A-z]+$/.match(user_params[:firstname]) == nil
        @errors[3] = /^[A-z]+$/.match(user_params[:surname]) == nil
        @errors[4] = params[:user][:position].blank?
        @errors[5] = (user_params[:address_line_1].blank? || user_params[:postcode].blank? || user_params[:city].blank? || user_params[:country].blank?) && (!user_params[:address_line_1].blank? || !user_params[:postcode].blank? || !user_params[:city].blank? || !user_params[:country].blank?)

      if @errors.any?
        @errors[0] = true
        render json: {success: false, error: @errors}
      else
        if params[:user][:position].is_a?(Hash)
          user_params[:position] = params[:user][:position][:title]
        else
          user_params[:position] = params[:user][:position]
        end
        if user_params[:address_line_1].blank?
          user_params[:address_line_1] = ""
          user_params[:city] = ""
          user_params[:postcode] = ""
          user_params[:lat] = 0.0
          user_params[:lng] = 0.0
          user_params[:country] = ""
        else
          user_params[:country] = user_params[:country][:country]
        end
        @user.update(user_params.except(:email))
        @user.update(first_time: false)
        render json: {success: true}
      end
    end
  end

  def create_member
    user_params = user_details
    @random_password = (0...8).map { (65 + rand(26)).chr }.join
    @company = Company.find(params[:id])

    if user_params.has_key?(:firstname) && user_params.has_key?(:surname) && user_params.has_key?(:email) && user_params.has_key?(:position)

      @errors = Array.new
        @errors[1] = User.exists?(:email => user_params[:email])
        @errors[2] = /^[A-z]+$/.match(user_params[:firstname]) == nil
        @errors[3] = /^[A-z]+$/.match(user_params[:surname]) == nil
        @errors[5] = params[:user][:position].blank?

      if(defined? user_params[:position][:title])
        params[:user][:position] = user_params[:position][:title]
      end

      if @errors.any?
        render json: {success: false, error: @errors}

      else
        @user = @company.users.new(firstname: user_params[:firstname],surname: user_params[:surname],email: user_params[:email],position: params[:user][:position], password: @random_password, contact_number: @company.users.count+1)
        if @user.save
            render json: {success: true}
        else
            render json: {success: true, unknown: true}
        end
      end

    else
      render json: {success: false, error_message: "There was an unknown issue with one of the entered fields please check you have completed this form and try again"}
    end
  end

  def change_password
    user_params = params.require(:user).permit(:email, :password, :new1, :new2)
    @user = User.authenticate(user_params)
    @errors = Array.new

    if !@user
      @errors[1] = true
    end

    if (user_params[:new1] == user_params[:new2]) && user_params[:new1].blank? && user_params[:new2].blank?
      @errors[2] = true
    end

    if @errors.any?
        @errors[0] = true
        render json: {success: false, error: @errors}
    else
      if @user.update_attribute(:password, user_params[:new1])
        @user.update(first_time: false)
        render json: {success: true}
      else
        @errors[0] = true
        @errors[3] = true
        render json: {success: false, error: @errors}
      end
    end
  end

  def investors
    render json: User.joins(:company).merge(Company.where(investor: true)), :only =>[:firstname, :surname, :company_id, :id]
  end

  def create_admin
    @random_password = (0...8).map { (65 + rand(26)).chr }.join
    user = Company.find(params[:user_company]).users.new(firstname: params[:user_firstname], surname: params[:user_surname], email: params[:user_email], address_line_1: params[:user_address_line_1], city: params[:user_city], country: params[:user_country], postcode: params[:user_postcode], lat: params[:user_lat], lng: params[:user_lng], telephone: params[:user_telephone], password: @random_password, contact_number: Company.find(params[:user_company]).users.count+1, accepted: params[:user_accepted])
    if user.save
      render json: {success: true}
      UserMailer.welcome_email(user, @random_password).deliver_now
    else
      render json: {success: false, unknown: true}
    end
  end
  def update_admin
    if !params[:user_id].nil? && !params[:user_id].blank?
      user = User.find(params[:user_id]);
      puts "**************************************"
      puts params
      if user.accepted == 0
        random_password = (0...8).map { (65 + rand(26)).chr }.join
        if User.find(params[:user_id]).update(firstname: params[:user_firstname], password: random_password, surname: params[:user_surname], address_line_1: params[:user_address_line_1], city: params[:user_city], country: params[:user_country], postcode: params[:user_postcode], lat: params[:user_lat], lng: params[:user_lng], telephone: params[:user_telephone], accepted: params[:user_accepted], company_id: params[:user_company])
          UserMailer.welcome_email(user, random_password).deliver_now
          render json: {success: "Details updated..."}
        else
          render json: {error: "Problem updating details..."}
        end
      else
        if User.find(params[:user_id]).update(firstname: params[:user_firstname], surname: params[:user_surname], address_line_1: params[:user_address_line_1], city: params[:user_city], country: params[:user_country], postcode: params[:user_postcode], lat: params[:user_lat], lng: params[:user_lng], telephone: params[:user_telephone], accepted: params[:user_accepted], company_id: params[:user_company])
          render json: {success: "Details updated..."}
        else
          render json: {error: "Problem updating details..."}
        end
      end
    end 
  end

  def get_users
    if !params[:user_email].nil? || params[:user_email] == ""
      users = User.arel_table
      #Explicit returns to stop if and unless both being executed
      User.where(users[:email].matches("#{params[:user_email]}%"))
    else
      #Explicit returns to stop if and unless both being executed
      User.all
    end
  end

  def meeting_location
    company = Company.find(params[:id])
    
    render json: {location: company.address_line_1.gsub(/\,/,"") + ', ' + company.city.gsub(/\,/,"") + ', ' + company.postcode.gsub(/\,/,"").upcase, lat: company.lat, lng: company.lng}
  end

  def forgot_password_step_0
    @user = User.find_by_email(params[:email])
    if @user
      if @user.accepted == 1
        @random_code = (0...5).map { (65 + rand(26)).chr }.join
        UserMailer.code_email(params[:email], @random_code).deliver_now
        @user.update(recovery_code: @random_code)
        render json: {success: true}
      else
        UserMailer.not_activated_email(params[:email]).deliver_now
        render json: {success: true}
      end
    else
      render json: {success: false}
    end
  end

  def forgot_password_step_1
    @user = User.find_by_email(params[:email])
    if @user.recovery_code == params[:code]
      puts " | * | Verify code: " + params[:code]
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  def forgot_password_step_2
    user_params = params.require(:user).permit(:email, :code, :new1, :new2)
    @errors = Array.new
    @user = User.find_by_email(user_params[:email])

    if @user.recovery_code != "done"
      if @user.recovery_code == user_params[:code]
        if (user_params[:new1] != user_params[:new2]) || user_params[:new1].blank? || user_params[:new2].blank?
            render json: {success: false}
        else
          if @user.update_attribute(:password, user_params[:new1])
            @user.update_attribute(:recovery_code, "done")
            render json: {success: true}
          else
            render json: {success: false}
          end
        end
      else
        render json: {success: false}
      end
    else
      render json: {success: false}
    end
  end

  def planner_info
    user_x = User.find(params[:id])
    user_x_hash = user_x.as_json
    company_x = user_x.company
    additional_details_x = user_x.additional_detail
    if user_x.postcode.blank?
      location = company_x
    else
      location = user_x
    end
    # Just add whatever you want to display in the info section here
    user_x_hash.update(company: company_x.name, currency: company_x.currency, details: additional_details_x, address_line_1: location.address_line_1, city: location.city, country: location.country, postcode: location.postcode, lat: location.lat, lng: location.lng)
    render json: user_x_hash
  end

  def planner_info_location
    user_x = User.find(params[:id])
    if user_x.postcode.blank?
      location = user_x.company
    else
      location = user_x
    end
    render json: {lat: location.lat, lng: location.lng, address_line_1: location.address_line_1}
  end
end
