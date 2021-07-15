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

ActiveRecord::Schema.define(version: 2021_07_14_192646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.integer "addressable_id", null: false
    t.string "line1", null: false
    t.string "line2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "addressable_type"
    t.text "country"
  end

  create_table "deals", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "closed_at"
    t.integer "property_id"
    t.index ["property_id"], name: "index_deals_on_property_id"
  end

  create_table "forms", id: :serial, force: :cascade do |t|
    t.integer "owner_id"
    t.string "title", null: false
    t.text "description"
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "generic", default: false
    t.string "owner_type"
    t.bigint "property_id"
    t.integer "sort"
    t.boolean "form_library"
    t.index ["property_id"], name: "index_forms_on_property_id"
  end

  create_table "gross_distributions", force: :cascade do |t|
    t.bigint "investment_id"
    t.string "amount"
    t.string "distribution_date"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investment_id"], name: "index_gross_distributions_on_investment_id"
  end

  create_table "investments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "deal_id", null: false
    t.string "amount_invested"
    t.date "invested_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "investing_entity"
    t.string "investor_email"
    t.string "investor_first_name"
    t.string "investor_last_name"
    t.string "amount_cents"
    t.string "amount_currency", default: "USD", null: false
    t.string "investor_entity"
    t.string "gross_distribution"
    t.string "gross_distribution_percentage"
    t.text "view_users", default: "{}"
    t.string "partner_id"
    t.string "total_investment_gross_distributions_amount"
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.integer "deal_id"
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "global", default: false
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.bigint "property_id"
    t.string "note_preview"
    t.index ["property_id"], name: "index_notes_on_property_id"
  end

  create_table "properties", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "closing_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.string "status"
    t.datetime "sale_date"
    t.string "gross_distributions"
    t.string "internal_rate_of_return"
    t.string "equity_multiple"
    t.string "property_type"
    t.text "description"
    t.string "funding_amount"
    t.string "target_irr"
    t.string "average_annual_return"
    t.string "total_investor_gross_distributions_amount"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "admin"
    t.boolean "approved"
    t.boolean "viewer"
    t.boolean "employee"
    t.boolean "investor_view"
    t.string "phone"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.string "total_investments_count"
    t.string "total_invested_amount"
    t.string "email_2"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "deals", "properties"
  add_foreign_key "forms", "properties"
  add_foreign_key "gross_distributions", "investments"
  add_foreign_key "notes", "properties"
end
