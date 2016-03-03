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

ActiveRecord::Schema.define(version: 20160301153524) do

  create_table "admits", force: :cascade do |t|
    t.integer  "status",        limit: 4,   default: 0
    t.datetime "admitted_date"
    t.string   "remark",        limit: 255
    t.string   "diagnosis",     limit: 255
    t.date     "edd"
    t.integer  "patient_id",    limit: 4
    t.integer  "doctor_id",     limit: 4
    t.integer  "room_id",       limit: 4
  end

  create_table "check_out_steps", force: :cascade do |t|
    t.integer  "admit_id",     limit: 4, null: false
    t.integer  "step",         limit: 4, null: false
    t.datetime "time_started"
    t.datetime "time_ended"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name",         limit: 255
    t.string "abbreviation", limit: 255
  end

  create_table "departments_wards", id: false, force: :cascade do |t|
    t.integer "ward_id",       limit: 4, null: false
    t.integer "department_id", limit: 4, null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "patients", id: false, force: :cascade do |t|
    t.integer "hn",              limit: 4
    t.string  "first_name",      limit: 255
    t.string  "last_name",       limit: 255
    t.string  "phone",           limit: 255
    t.integer "sex",             limit: 4
    t.integer "age",             limit: 4
    t.string  "social_security", limit: 255
  end

  create_table "rooms", force: :cascade do |t|
    t.string  "number",  limit: 255
    t.integer "status",  limit: 4,   default: 0
    t.integer "price",   limit: 4
    t.integer "ward_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string  "username",        limit: 255
    t.integer "role",            limit: 4
    t.string  "password_digest", limit: 255
    t.string  "remember_digest", limit: 255
    t.integer "ward_id",         limit: 4
  end

  create_table "wards", force: :cascade do |t|
    t.string  "name",   limit: 255
    t.string  "remark", limit: 255
    t.integer "phone",  limit: 4
  end

end
