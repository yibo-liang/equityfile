# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151013194103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_details", force: :cascade do |t|
    t.boolean  "aerospace_defense"
    t.boolean  "alternative_energy"
    t.boolean  "automobiles_parts"
    t.boolean  "banks"
    t.boolean  "beverages"
    t.boolean  "chemicals"
    t.boolean  "construction_materials"
    t.boolean  "electricity"
    t.boolean  "electronic_electrical_equipment"
    t.boolean  "equity_investment_instruments"
    t.boolean  "financial_services"
    t.boolean  "fixed_line_telecommunications"
    t.boolean  "food_drug_retailers"
    t.boolean  "food_producers"
    t.boolean  "forestry_paper"
    t.boolean  "gas_water_multiutilities"
    t.boolean  "general_industrials"
    t.boolean  "general_retailers"
    t.boolean  "health_care_equipment_services"
    t.boolean  "household_goods_home_construction"
    t.boolean  "industrial_engineering"
    t.boolean  "industrial_metals_mining"
    t.boolean  "industrial_transportation"
    t.boolean  "leisure_goods"
    t.boolean  "life_insurance"
    t.boolean  "media"
    t.boolean  "mining"
    t.boolean  "mobile_telecommunications"
    t.boolean  "nonequity_investment_instruments"
    t.boolean  "nonlife_insurance"
    t.boolean  "oil_gas_producers"
    t.boolean  "oil_equipment_services_distribution"
    t.boolean  "personal_goods"
    t.boolean  "pharmaceuticals_biotechnology"
    t.boolean  "real_estate_investment_services"
    t.boolean  "real_estate_investment_trusts"
    t.boolean  "software_computer_services"
    t.boolean  "support_services"
    t.boolean  "technology_hardware_equipment"
    t.boolean  "tobacco"
    t.boolean  "travel_leisure"
    t.boolean  "growth"
    t.boolean  "value"
    t.boolean  "income"
    t.boolean  "garp"
    t.boolean  "contrarian"
    t.boolean  "momentum"
    t.integer  "user_id"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.decimal  "assets",                              precision: 8, scale: 2, default: 0.0
  end

  add_index "additional_details", ["user_id"], name: "index_additional_details_on_user_id", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id", using: :btree

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.boolean  "accepted",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "created_by_user"
  end

  add_index "appointments", ["company_id"], name: "index_appointments_on_company_id", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "postcode"
    t.string   "symbol"
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.integer  "application_status", limit: 2,                           default: 0,               null: false
    t.boolean  "investor",                                               default: false
    t.string   "classification",                                         default: "Uncategorised"
    t.decimal  "assets",                       precision: 8,  scale: 2,  default: 0.0
    t.decimal  "equity_assets",                precision: 8,  scale: 2,  default: 0.0
    t.decimal  "uk_equity_assets",             precision: 8,  scale: 2,  default: 0.0
    t.string   "currency"
    t.string   "city"
    t.decimal  "lat",                          precision: 15, scale: 10, default: 0.0
    t.decimal  "lng",                          precision: 15, scale: 10, default: 0.0
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "startsAt"
    t.string   "endsAt"
    t.boolean  "editable",             default: false
    t.boolean  "deletable",            default: false
    t.boolean  "incrementsBadgeTotal", default: true
    t.integer  "appointment_id"
    t.string   "event_type"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "location"
    t.string   "postcode"
  end

  add_index "events", ["appointment_id"], name: "index_events_on_appointment_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "interests", ["company_id"], name: "index_interests_on_company_id", using: :btree
  add_index "interests", ["user_id"], name: "index_interests_on_user_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matches", ["company_id"], name: "index_matches_on_company_id", using: :btree
  add_index "matches", ["user_id"], name: "index_matches_on_user_id", using: :btree

  create_table "meeting_instances", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "investor_id"
    t.boolean  "accepted"
    t.integer  "time_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "meeting_instances", ["meeting_id"], name: "index_meeting_instances_on_meeting_id", using: :btree
  add_index "meeting_instances", ["user_id"], name: "index_meeting_instances_on_user_id", using: :btree

  create_table "meeting_times", force: :cascade do |t|
    t.datetime "time"
    t.integer  "meeting_id"
    t.integer  "meeting_instance_id"
    t.boolean  "reserved",            default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "meeting_times", ["meeting_id"], name: "index_meeting_times_on_meeting_id", using: :btree
  add_index "meeting_times", ["meeting_instance_id"], name: "index_meeting_times_on_meeting_instance_id", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.string   "location",      default: "N/A"
    t.boolean  "group_meeting", default: false
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "meetings", ["user_id"], name: "index_meetings_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "posted_by"
    t.integer  "posted_to"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "registers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tag_relations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tag_relations", ["tag_id"], name: "index_tag_relations_on_tag_id", using: :btree
  add_index "tag_relations", ["user_id"], name: "index_tag_relations_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "firstname"
    t.string   "surname"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "role"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "postcode"
    t.string   "position"
    t.integer  "contact_number"
    t.integer  "company_id"
    t.boolean  "contact"
    t.string   "telephone"
    t.boolean  "first_time",                                         default: true
    t.integer  "accepted",       limit: 2,                           default: 0,    null: false
    t.string   "recovery_code"
    t.string   "city"
    t.string   "country"
    t.decimal  "lat",                      precision: 15, scale: 10, default: 0.0
    t.decimal  "lng",                      precision: 15, scale: 10, default: 0.0
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree

end
