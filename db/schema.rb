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

ActiveRecord::Schema.define(version: 20161115020229) do

  create_table "admins", force: :cascade do |t|
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "bookings", force: :cascade do |t|
    t.integer  "intake_id"
    t.integer  "promo_code_id"
    t.integer  "people_attending"
    t.decimal  "total_cost"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.string   "age"
    t.string   "city"
    t.string   "country"
    t.string   "business_name",    default: "N/A"
    t.string   "business_address", default: "N/A"
    t.boolean  "cancelled",        default: false
    t.string   "stripe_token"
    t.decimal  "gst"
    t.decimal  "discount"
    t.string   "discount_code"
    t.boolean  "zip_money",        default: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "courses", force: :cascade do |t|
    t.string   "course_type"
    t.string   "name"
    t.text     "description"
    t.text     "tagline"
    t.string   "slug"
    t.decimal  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "course_image"
    t.boolean  "active"
    t.string   "subtype"
    t.string   "per"
  end

  create_table "fast_track_payments", force: :cascade do |t|
    t.decimal  "amount"
    t.boolean  "paid",       default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "pay_type"
    t.string   "student_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "intakes", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "start"
    t.datetime "finish"
    t.string   "location"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "teacher_name"
    t.string   "teacher_image"
    t.string   "days"
    t.string   "status",        default: "Active"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "booking_id"
    t.decimal  "amount"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "paid",       default: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "lead"
    t.text     "content"
    t.string   "image"
    t.boolean  "publish"
    t.date     "published_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "slug"
    t.string   "author_name"
    t.string   "author_image"
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "percent"
    t.string   "note"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "valid_code",     default: true
    t.string   "code_type"
    t.date     "expiry_date"
    t.integer  "number_of_uses"
  end

  create_table "testimonials", force: :cascade do |t|
    t.string   "name"
    t.string   "prev_role"
    t.string   "image"
    t.string   "quote"
    t.string   "vid_link"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
