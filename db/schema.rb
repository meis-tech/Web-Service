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

ActiveRecord::Schema.define(version: 20160711220406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: true do |t|
    t.string   "device_id"
    t.string   "push_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "download_tickets", force: true do |t|
    t.integer  "profile_id"
    t.integer  "hosted_file_id"
    t.string   "transfer_means"
    t.datetime "time_expired"
    t.boolean  "page_visited",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "download_tickets", ["hosted_file_id"], name: "index_download_tickets_on_hosted_file_id", using: :btree
  add_index "download_tickets", ["profile_id"], name: "index_download_tickets_on_profile_id", using: :btree

  create_table "emergency_alerts", force: true do |t|
    t.integer  "personal_health_record_id"
    t.integer  "profile_id"
    t.text     "problem"
    t.string   "condition"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emergency_alerts", ["personal_health_record_id"], name: "index_emergency_alerts_on_personal_health_record_id", using: :btree
  add_index "emergency_alerts", ["profile_id"], name: "index_emergency_alerts_on_profile_id", using: :btree

  create_table "environment_users", id: false, force: true do |t|
    t.integer "environment_id"
    t.integer "user_id"
    t.boolean "owner?",         default: false
  end

  add_index "environment_users", ["environment_id"], name: "index_environment_users_on_environment_id", using: :btree
  add_index "environment_users", ["user_id"], name: "index_environment_users_on_user_id", using: :btree

  create_table "environments", force: true do |t|
    t.integer  "user_id"
    t.string   "company"
    t.string   "main_contact_name"
    t.string   "main_contact_number"
    t.string   "address"
    t.string   "type_of_entity"
    t.string   "description"
    t.boolean  "minors?"
    t.boolean  "approved?"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "environments", ["user_id"], name: "index_environments_on_user_id", using: :btree

  create_table "hosted_files", force: true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "phone_type"
    t.string   "description"
    t.string   "file_name"
    t.boolean  "shown",          default: false
    t.integer  "times_modified", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personal_health_records", force: true do |t|
    t.integer  "profile_id"
    t.boolean  "active"
    t.text     "allergies"
    t.string   "blood_type"
    t.text     "chronic_disease"
    t.text     "medication"
    t.boolean  "organ_donor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personal_health_records", ["profile_id"], name: "index_personal_health_records_on_profile_id", using: :btree

  create_table "profile_passes", force: true do |t|
    t.string   "serial_no"
    t.integer  "profile_id_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "DOB"
    t.string   "sex"
    t.string   "address"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "emergency_contact"
    t.text     "text"
    t.string   "last_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_passes", ["profile_id_id"], name: "index_profile_passes_on_profile_id_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "DOB"
    t.string   "sex"
    t.string   "address"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "emergency_contact"
    t.text     "text"
    t.string   "url"
    t.boolean  "attached"
    t.integer  "environment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["environment_id"], name: "index_profiles_on_environment_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "registrations", force: true do |t|
    t.string   "device_id"
    t.string   "passtype_id"
    t.string   "serial_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "status"
    t.string   "text"
    t.string   "approved?"
    t.boolean  "completed?"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "role_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "contact_number"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
