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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130113174750) do

  create_table "account_balances", :force => true do |t|
    t.integer  "account_id"
    t.date     "created_on"
    t.decimal  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "accounts", :force => true do |t|
    t.integer  "bank_id"
    t.string   "name"
    t.string   "currency"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "banks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.integer  "infakt_client_id"
    t.string   "name"
    t.string   "nip"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "street"
    t.string   "city"
    t.string   "postcode"
    t.string   "country"
  end

  create_table "currencies", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "days", :force => true do |t|
    t.string   "type"
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "days", ["date"], :name => "index_days_on_date"

  create_table "delegation_costs", :force => true do |t|
    t.integer  "delegation_id"
    t.string   "name"
    t.integer  "number"
    t.decimal  "amount"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "delegations", :force => true do |t|
    t.string   "number"
    t.datetime "started_at"
    t.datetime "left_country_at"
    t.datetime "returned_country_at"
    t.datetime "ended_at"
    t.integer  "infakt_client_id"
    t.string   "border_city"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "exchange_rates", :force => true do |t|
    t.decimal  "rate"
    t.string   "currency"
    t.date     "date"
    t.string   "table"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "from"
  end

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.integer  "infakt_invoice_id"
    t.integer  "infakt_client_id"
    t.integer  "exchange_rate_id"
    t.decimal  "total_gross"
    t.decimal  "total_net"
    t.decimal  "total_vat"
    t.string   "currency"
    t.text     "notice"
    t.date     "created_on"
    t.date     "sold_on"
    t.date     "pay_on"
    t.string   "pdf_url"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.decimal  "total_gross_in_pln"
  end

end
