class Charge < ActiveRecord::Base
  belongs_to :charge_transaction
  has_one :creditor, :class_name => "Person"
  has_one :debtor, :class_name => "Person"
  
  def balance(person)
    if person == debtor and person == creditor
      return 0
    elsif person == debtor
      return -amount
    elsif person == creditor
      return amount
    else
      return 0
    end
  end
end
