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

ActiveRecord::Schema.define(version: 20150718010412) do

  create_table "circuits", force: :cascade do |t|
    t.string   "ergast_circuit_code", null: false
    t.string   "name",                null: false
    t.string   "locality",            null: false
    t.string   "country",             null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "constructors", force: :cascade do |t|
    t.string   "ergast_constructor_code"
    t.string   "name",                    null: false
    t.string   "nationality",             null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "ergast_driver_id",   null: false
    t.string   "ergast_driver_code", null: false
    t.string   "name",               null: false
    t.integer  "number",             null: false
    t.integer  "constructor_id",     null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "drivers", ["constructor_id"], name: "index_drivers_on_constructor_id"

  create_table "qly_results", force: :cascade do |t|
    t.integer  "round_id",     null: false
    t.integer  "qly_result_1", null: false
    t.integer  "qly_result_2", null: false
    t.integer  "qly_result_3", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "qly_results", ["round_id"], name: "index_qly_results_on_round_id"

  create_table "race_results", force: :cascade do |t|
    t.integer  "round_id",       null: false
    t.integer  "race_result_1",  null: false
    t.integer  "race_result_2",  null: false
    t.integer  "race_result_3",  null: false
    t.integer  "race_result_4",  null: false
    t.integer  "race_result_5",  null: false
    t.integer  "race_result_6",  null: false
    t.integer  "race_result_7",  null: false
    t.integer  "race_result_8",  null: false
    t.integer  "race_result_9",  null: false
    t.integer  "race_result_10", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "race_results", ["round_id"], name: "index_race_results_on_round_id"

  create_table "rounds", force: :cascade do |t|
    t.string   "round_number",  null: false
    t.integer  "circuit_id",    null: false
    t.datetime "qly_datetime",  null: false
    t.datetime "race_datetime", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "rounds", ["circuit_id"], name: "index_rounds_on_circuit_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
