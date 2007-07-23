class ChargeTransaction < ActiveRecord::Base
  has_many :charges, :foreign_key => "transaction_id"
  
  def balance(user)
    total = 0.0
    charges.each do |charge|
      total += charge.balance(user)
    end
    return total
  end
end
