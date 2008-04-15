class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index "charges", :transaction_id
    add_index "charges", :debtor_id
    add_index "charges", :creditor_id
    add_index "charges", [:debtor_id, :creditor_id]
  end

  def self.down
    remove_index "charges", :transaction_id
    remove_index "charges", :debtor_id
    remove_index "charges", :creditor_id
    remove_index "charges", :column => [:debtor_id, :creditor_id]
  end
end
