class CreateChargeTransactions < ActiveRecord::Migration
  def self.up
    create_table :charge_transactions do |t|
      t.column :description, :string
      t.column :transaction_date, :date
    end
  end

  def self.down
    drop_table :charge_transactions
  end
end
