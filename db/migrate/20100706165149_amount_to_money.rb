class Charge < ActiveRecord::Base
  def raw_amount
    read_attribute(:amount)
  end
  
  def raw_amount=(amount)
    write_attribute(:amount, amount)
  end
end

class AmountToMoney < ActiveRecord::Migration
  
  def self.up
    add_column :charges, :cents, :integer, :null => false, :default => 0
    add_column :charges, :currency, :string
    
    Charge.all.each do |charge|
      charge.cents = (charge.raw_amount * 100.0).round
      charge.currency = "USD"
      charge.save!
    end
    
    remove_column :charges, :amount
  end

  def self.down
    add_column :charges, :amount, :float
    
    Charge.all.each do |charge|
      charge.raw_amount = charge.as_us_dollar.cents.to_f / 100.0
      charge.save!
    end
    
    remove_column :charges, :cents
    remove_column :charges, :currency
  end
end
