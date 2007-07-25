class UseCreatedAtForTransactions < ActiveRecord::Migration
  def self.up
    rename_column "charge_transactions", "transaction_date", "created_at"
  end

  def self.down
    rename_column "charge_transactions", "created_at", "transaction_date"
  end
end
