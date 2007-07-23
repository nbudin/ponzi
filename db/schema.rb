# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 3) do

  create_table "charge_transactions", :force => true do |t|
    t.column "description",      :string
    t.column "transaction_date", :date
  end

  create_table "charges", :force => true do |t|
    t.column "transaction_id", :integer
    t.column "creditor_id",    :integer
    t.column "debtor_id",      :integer
    t.column "amount",         :float
  end

  create_table "engine_schema_info", :id => false, :force => true do |t|
    t.column "engine_name", :string
    t.column "version",     :integer
  end

  create_table "housemates", :force => true do |t|
    t.column "person_id", :integer
  end

end
