class Charge < ActiveRecord::Base
  belongs_to :charge_transaction
  belongs_to :creditor, :foreign_key => "creditor_id", :class_name => "Person"
  belongs_to :debtor, :foreign_key => "debtor_id", :class_name => "Person"
  
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
  
  def other(person)
    if person == debtor
      return creditor
    elsif person == creditor
      return debtor
    end
  end
end
