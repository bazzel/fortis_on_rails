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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100915150809) do

  create_table "bank_accounts", :force => true do |t|
    t.string   "account_number", :limit => 10
    t.string   "description",    :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upload_details", :force => true do |t|
    t.string   "rekeningnummer",       :limit => 50
    t.string   "ten_laste_van",        :limit => 50
    t.string   "boekdatum",            :limit => 50
    t.string   "valutadatum",          :limit => 50
    t.string   "bedrag",               :limit => 50
    t.string   "munt_vd_rekening",     :limit => 50
    t.string   "begunstigde",          :limit => 50
    t.string   "begunstigde_rekening", :limit => 50
    t.string   "mutatie_omschrijving", :limit => 50
    t.string   "regel_1",              :limit => 50
    t.string   "regel_2",              :limit => 50
    t.string   "regel_3",              :limit => 50
    t.string   "regel_4",              :limit => 50
    t.string   "regel_5",              :limit => 50
    t.integer  "upload_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upload_details", ["upload_id"], :name => "index_upload_details_on_upload_id"

  create_table "uploads", :force => true do |t|
    t.date     "period_start"
    t.date     "period_end"
    t.integer  "balance_start"
    t.integer  "balance_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "csv_updated_at"
    t.integer  "bank_account_id"
  end

  add_index "uploads", ["bank_account_id"], :name => "index_uploads_on_bank_account_id"

end
