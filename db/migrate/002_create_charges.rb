class CreateCharges < ActiveRecord::Migration
  def self.up
    create_table :charges do |t|
      t.column :transaction_id, :integer
      t.column :creditor_id, :integer
      t.column :debtor_id, :integer
      t.column :amount, :float
    end
  end

  def self.down
    drop_table :charges
  end
end
