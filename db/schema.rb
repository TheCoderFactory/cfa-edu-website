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

ActiveRecord::Schema.define(version: 20160523035321) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "intake_id"
    t.integer  "promo_code_id"
    t.integer  "people_attending"
    t.decimal  "total_cost"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "course_type"
    t.string   "name"
    t.text     "description"
    t.text     "tagline"
    t.string   "slug"
    t.decimal  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "intakes", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "start"
    t.datetime "finish"
    t.string   "location"
    t.integer  "class_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "booking_id"
    t.decimal  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "percent"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
