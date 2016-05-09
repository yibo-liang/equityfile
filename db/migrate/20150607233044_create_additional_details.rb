class CreateAdditionalDetails < ActiveRecord::Migration
  def change
    create_table :additional_details do |t|
      t.boolean :aerospace_defense
	  t.boolean :alternative_energy
	  t.boolean :automobiles_parts
	  t.boolean :banks
	  t.boolean :beverages
	  t.boolean :chemicals
	  t.boolean :construction_materials
	  t.boolean :electricity
	  t.boolean :electronic_electrical_equipment
	  t.boolean :equity_investment_instruments
	  t.boolean :financial_services
	  t.boolean :fixed_line_telecommunications
	  t.boolean :food_drug_retailers
	  t.boolean :food_producers
	  t.boolean :forestry_paper
	  t.boolean :gas_water_multiutilities
	  t.boolean :general_industrials
	  t.boolean :general_retailers
	  t.boolean :health_care_equipment_services
	  t.boolean :household_goods_home_construction
	  t.boolean :industrial_engineering
	  t.boolean :industrial_metals_mining
	  t.boolean :industrial_transportation
	  t.boolean :leisure_goods
	  t.boolean :life_insurance
	  t.boolean :media
	  t.boolean :mining
	  t.boolean :mobile_telecommunications
	  t.boolean :nonequity_investment_instruments
	  t.boolean :nonlife_insurance
	  t.boolean :oil_gas_producers
	  t.boolean :oil_equipment_services_distribution
	  t.boolean :personal_goods
	  t.boolean :pharmaceuticals_biotechnology
	  t.boolean :real_estate_investment_services
	  t.boolean :real_estate_investment_trusts
	  t.boolean :software_computer_services
	  t.boolean :support_services
	  t.boolean :technology_hardware_equipment
	  t.boolean :tobacco
	  t.boolean :travel_leisure
	  t.boolean :growth
      t.boolean :value
      t.boolean :income
      t.boolean :garp
      t.boolean :contrarian
      t.boolean :momentum
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
    add_column :additional_details, :assets, :decimal, :precision => 8, :scale => 2, default: 0.00
  end
end
