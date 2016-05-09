class CompaniesController < ApplicationController
  def index
    @companies = Company.all

    render json: @companies
  end
  
  def index_small_investors
    @companies = Company.where(investor: true)
    render json: @companies, :only =>[:name, :symbol, :id]
  end

  def index_small_not_investors
    @companies = Company.where(investor: false, application_status: 1)
    render json: @companies, :only =>[:name, :symbol, :id, :classification]
  end

  def index_small
    @companies = Company.all
    render json: @companies, :only =>[:name, :symbol, :id]
  end
  def destroy
    if Company.find(params[:company_id]).destroy
      render json: {success: "Company destroyed successfully..."}
    else
      render json: {error: "Problem destroying company..."}
    end
  end
  def create
    if !params[:company_classification].blank? && !params[:company_classification].nil? && !params[:company_name].nil? && !params[:company_application_status].nil?
      @company = Company.create(name: params[:company_name], 
                      application_status: params[:company_application_status], 
                      symbol: params[:company_symbol], 
                      address_line_1: params[:company_address_line_1],  
                      postcode: params[:company_postcode],
                      country: params[:company_country],
                      city: params[:company_city],
                      lat: params[:company_lat],
                      lng: params[:company_lng])
		end
  end

  def show
    @company = Company.find(params[:company_id])
    
    render json: @company unless @company.nil?
    render status: 402 if @company.nil?
  end

  def update
    company_params = company_details
    if Company.exists?(company_params[:id])
      @errors = Array.new

      @company = Company.find(company_params[:id])
      
        @errors[1] = company_params[:address_line_1].blank? || company_params[:postcode].blank? || company_params[:city].blank? || !defined? company_params[:country][:country]
        @errors[3] = (defined? company_params[:assets]) && /\A[+]?[0-9]+(\.[0-9][0-9]?)?\z/.match(company_params[:assets].to_s) == nil
        @errors[4] = (defined? company_params[:equity_assets]) && /\A[+]?[0-9]+(\.[0-9][0-9]?)?\z/.match(company_params[:equity_assets].to_s) == nil
        @errors[5] = (defined? company_params[:uk_equity_assets]) && /\A[+]?[0-9]+(\.[0-9][0-9]?)?\z/.match(company_params[:uk_equity_assets].to_s) == nil
      
      if @errors.any?
        @errors[0] = true
        render json: {success: false, error: @errors}
      else
        company_params[:country] = company_params[:country][:country]
        @company.update(company_params.except(:name, :postcode, :symbol))
        render json: {success: true}
      end
    end

  end

  def company_details
    params.require(:company).permit(:id, :name, :symbol, :address_line_1, :address_line_2, :address_line_3, :postcode, :assets, :equity_assets, :uk_equity_assets, :currency, :city, :lat, :lng, country: [:country])
  end

  def search
    @companies = get_companies.order(name: :asc).to_a
    puts @companies.to_json
    render json: @companies
  end

  def update_admin
      Company.find(params[:company_id]).update(name: params[:company_name], application_status: params[:company_application_status], symbol: params[:company_symbol], address_line_1: params[:company_address_line_1], city: params[:company_city], country: params[:company_country], postcode: params[:company_postcode], lat: params[:company_lat], lng: params[:company_lng], classification: params[:company_classification], investor: params[:company_type])

      render json: {success: "Details updated..."}
  end

  def get_companies
    companies = Company.arel_table
    if !params[:company_name].nil? || params[:company_name] == ""
      if (params[:last_company_id].nil? || params[:last_company_id].blank?) && (params[:reverse_company_id].nil? || params[:reverse_company_id].blank?)
        #Explicit returns to stop if and unless both being executed
        Company
          .where(companies[:name].matches("#{params[:company_name]}%")).order(:id)
          .limit(20)
      elsif (!params[:last_company_id].nil? || !params[:last_company_id].blank?) && (params[:reverse_company_id].nil? || params[:reverse_company_id].blank?)
        Company.where(
            companies[:name]
              .matches("#{params[:company_name]}%")
              .and(companies[:id]
                .gteq(params[:last_company_id])
              )
          ).order(:id)
          .limit(20)
      elsif (!params[:reverse_company_id].nil? || !params[:reverse_company_id].blank?) && (params[:last_company_id].nil? || params[:last_company_id].blank?)
        Company.where(
            companies[:name]
              .matches("#{params[:company_name]}%")
              .and(companies[:id]
                .lteq(params[:reverse_company_id])
              )
          ).order(:id)
          .limit(20)
      end
    else
      #Explicit returns to stop if and unless both being executed
      if (params[:last_company_id].nil? || params[:last_company_id].blank?) && (params[:reverse_company_id].nil? || params[:reverse_company_id].blank?)
        #Explicit returns to stop if and unless both being executed
        Company.all.order(:id)
          .limit(20)
      elsif (!params[:last_company_id].nil? || !params[:last_company_id].blank?) && (params[:reverse_company_id].nil? || params[:reverse_company_id].blank?)
        Company.where("id > #{params[:last_company_id]}").order(:id)
          .limit(20)
      elsif (!params[:reverse_company_id].nil? || !params[:reverse_company_id].blank?) && (params[:reverse_company_id].nil? || params[:reverse_company_id].blank?)
        Company.where("id < #{params[:reverse_company_id]}").order(:id)
          .limit(20).offset(params[:offset] * 20)
      end      
    end
  end
end
