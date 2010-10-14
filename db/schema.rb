# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100706165149) do

  create_table "charge_transactions", :force => true do |t|
    t.string "description"
    t.date   "created_at"
  end

  create_table "charges", :force => true do |t|
    t.integer "transaction_id"
    t.integer "creditor_id"
    t.integer "debtor_id"
    t.integer "cents",          :default => 0, :null => false
    t.string  "currency"
  end

  add_index "charges", ["creditor_id"], :name => "index_charges_on_creditor_id"
  add_index "charges", ["debtor_id", "creditor_id"], :name => "index_charges_on_debtor_id_and_creditor_id"
  add_index "charges", ["debtor_id"], :name => "index_charges_on_debtor_id"
  add_index "charges", ["transaction_id"], :name => "index_charges_on_transaction_id"

  create_table "chore_group_candidates", :force => true do |t|
    t.integer "position"
    t.integer "chore_group_id"
    t.integer "housemate_id"
  end

  create_table "chore_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "initial_assignment_time"
    t.integer  "house_id"
  end

  create_table "chore_groups_chores", :id => false, :force => true do |t|
    t.integer "chore_id"
    t.integer "chore_group_id"
  end

  create_table "chores", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "frequency_amount"
    t.string  "frequency_unit"
    t.integer "forced_timing"
  end

  create_table "housemates", :force => true do |t|
    t.integer  "preferred_hour"
    t.integer  "preferred_dow"
    t.string   "username"
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
  end

  add_index "housemates", ["username"], :name => "index_housemates_on_username", :unique => true

  create_table "housemates_houses", :id => false, :force => true do |t|
    t.integer "house_id"
    t.integer "housemate_id"
  end

  create_table "houses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
