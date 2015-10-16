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

ActiveRecord::Schema.define(version: 20150927200651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emergency_alerts", force: true do |t|
    t.integer  "personal_health_record_id"
    t.integer  "patient_id"
    t.text     "problem"
    t.string   "condition"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emergency_alerts", ["patient_id"], name: "index_emergency_alerts_on_patient_id", using: :btree
  add_index "emergency_alerts", ["personal_health_record_id"], name: "index_emergency_alerts_on_personal_health_record_id", using: :btree

  create_table "patients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.string   "DOB"
    t.string   "sex"
    t.string   "address"
    t.string   "email_address"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "personal_id"
  end

  create_table "personal_health_records", force: true do |t|
    t.integer  "patient_id"
    t.boolean  "active"
    t.text     "allergies"
    t.string   "blood_type"
    t.text     "chronic_disease"
    t.text     "medication"
    t.boolean  "organ_donor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "personal_id"
  end

  add_index "personal_health_records", ["patient_id"], name: "index_personal_health_records_on_patient_id", using: :btree

end
