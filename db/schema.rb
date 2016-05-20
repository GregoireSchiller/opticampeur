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

ActiveRecord::Schema.define(version: 20160519171621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string   "total_price"
    t.integer  "camping_car_id"
    t.integer  "user_id"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.date     "check_in"
    t.date     "check_out"
    t.string   "booking_status", default: "En attente de confirmation"
  end

  add_index "bookings", ["camping_car_id"], name: "index_bookings_on_camping_car_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "camping_car_reviews", force: :cascade do |t|
    t.string   "rating"
    t.string   "comment"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "camping_car_reviews", ["booking_id"], name: "index_camping_car_reviews_on_booking_id", using: :btree

  create_table "camping_cars", force: :cascade do |t|
    t.string   "capacity_grey_card"
    t.string   "brand"
    t.string   "category"
    t.string   "car_model"
    t.string   "sleep_capacity"
    t.string   "fuel"
    t.string   "consumption"
    t.string   "km"
    t.string   "gear_type"
    t.string   "entry_into_circulation"
    t.string   "original_value"
    t.string   "registration_country"
    t.string   "price_per_day"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "plate"
  end

  add_index "camping_cars", ["user_id"], name: "index_camping_cars_on_user_id", using: :btree

  create_table "user_reviews", force: :cascade do |t|
    t.string   "rating"
    t.string   "comment"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_reviews", ["booking_id"], name: "index_user_reviews_on_booking_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "nationality"
    t.string   "profile_picture"
    t.string   "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "country"
    t.string   "phone_number"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "rails"
    t.string   "g"
    t.string   "migration"
    t.string   "AddOmniauthToUsers"
    t.string   "provider"
    t.string   "uid"
    t.string   "picture"
    t.string   "token"
    t.datetime "token_expiry"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bookings", "camping_cars"
  add_foreign_key "bookings", "users"
  add_foreign_key "camping_car_reviews", "bookings"
  add_foreign_key "camping_cars", "users"
  add_foreign_key "user_reviews", "bookings"
end
