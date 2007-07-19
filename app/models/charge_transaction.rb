class ChargeTransaction < ActiveRecord::Base
  has_many :charges
  
  def balance(user)
    total = 0.0
    charges.each do |charge|
      total += charge.balance(user)
    end
    return total
  end
end
