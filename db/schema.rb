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

ActiveRecord::Schema.define(version: 2019_02_19_184305) do

  create_table "charities", force: :cascade do |t|
    t.string "name"
    t.string "discription"
    t.integer "donations_received", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "confirms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.boolean "attend", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_receipts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "charity_id"
    t.integer "donations_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", force: :cascade do |t|
    t.integer "event_id"
    t.integer "sponsor_id"
    t.integer "amount_per_volunt`eer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "coordinator_id"
    t.datetime "datetime"
    t.string "title"
    t.integer "max_volunteers"
    t.string "address"
    t.string "description"
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "first_name", default: "Anonymous Donor"
    t.string "last_name", default: ""
    t.integer "credit", default: 0
    t.integer "total_donations", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "first_name"
    t.string "last_name"
    t.integer "credit", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
