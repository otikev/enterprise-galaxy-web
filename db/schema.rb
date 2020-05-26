# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_26_123641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broad_sector_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "business_forms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enterprises", force: :cascade do |t|
    t.bigint "business_form_id"
    t.bigint "broad_sector_name_id"
    t.string "business_name"
    t.string "contact_email"
    t.date "start_of_operations_date"
    t.date "registration_date"
    t.string "postal_address"
    t.string "postal_code"
    t.string "country"
    t.string "city"
    t.string "office_number"
    t.string "office_phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at"
    t.index ["broad_sector_name_id"], name: "index_enterprises_on_broad_sector_name_id"
    t.index ["business_form_id"], name: "index_enterprises_on_business_form_id"
  end

end
