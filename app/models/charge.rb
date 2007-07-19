class Charge < ActiveRecord::Base
  belongs_to :charge_transaction
  has_one :creditor, :class_name => "User"
  has_one :debtor, :class_name => "User"
  
  def balance(user)
    if user == debtor and user == creditor
      return 0
    elsif user == debtor
      return -amount
    elsif user == creditor
      return amount
    else
      return 0
    end
  end
end
