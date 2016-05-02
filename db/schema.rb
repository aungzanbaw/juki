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

ActiveRecord::Schema.define(version: 20160501075631) do

  create_table "currencies", force: :cascade do |t|
    t.integer  "burma"
    t.integer  "us"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machines", force: :cascade do |t|
    t.string   "model"
    t.string   "series"
    t.string   "namemm"
    t.string   "nameeng"
    t.text     "description"
    t.string   "company"
    t.integer  "stock"
    t.integer  "qty"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "motors", force: :cascade do |t|
    t.string   "brand"
    t.string   "name"
    t.integer  "watt"
    t.integer  "qty"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "msale_details", force: :cascade do |t|
    t.integer  "msale_id"
    t.integer  "machine_id"
    t.integer  "qty"
    t.integer  "price"
    t.string   "chassis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "msale_details", ["machine_id"], name: "index_msale_details_on_machine_id"
  add_index "msale_details", ["msale_id"], name: "index_msale_details_on_msale_id"

  create_table "msales", force: :cascade do |t|
    t.boolean  "proforma"
    t.string   "customer"
    t.string   "nic"
    t.string   "address"
    t.integer  "phone"
    t.integer  "total"
    t.boolean  "debt"
    t.integer  "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "needles", force: :cascade do |t|
    t.string   "model"
    t.string   "category"
    t.string   "size"
    t.integer  "machine_id"
    t.integer  "stock"
    t.integer  "qty"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "needles", ["machine_id"], name: "index_needles_on_machine_id"

  create_table "parts", force: :cascade do |t|
    t.string   "model"
    t.string   "namemm"
    t.string   "nameeng"
    t.text     "description"
    t.integer  "machine_id"
    t.integer  "stock"
    t.integer  "qty"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "parts", ["machine_id"], name: "index_parts_on_machine_id"

  create_table "purchase_details", force: :cascade do |t|
    t.integer  "purchase_id"
    t.integer  "stockable_id"
    t.string   "stockable_type"
    t.integer  "qty"
    t.integer  "price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "purchase_details", ["purchase_id"], name: "index_purchase_details_on_purchase_id"
  add_index "purchase_details", ["stockable_id"], name: "index_purchase_details_on_stockable_id"
  add_index "purchase_details", ["stockable_type"], name: "index_purchase_details_on_stockable_type"

  create_table "purchases", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "nic"
    t.string   "phone"
    t.integer  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.integer  "phone"
    t.string   "address"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "stands", force: :cascade do |t|
    t.string   "brand"
    t.string   "name"
    t.integer  "qty"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.string   "brand"
    t.string   "name"
    t.integer  "width"
    t.integer  "height"
    t.integer  "qty"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
