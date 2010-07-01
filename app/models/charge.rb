class Charge < ActiveRecord::Base
  belongs_to :charge_transaction, :foreign_key => "transaction_id"
  belongs_to :creditor, :foreign_key => "creditor_id", :class_name => "Housemate"
  belongs_to :debtor, :foreign_key => "debtor_id", :class_name => "Housemate"
  
  scope :between, lambda { |me, other|
    where(
      ["(creditor_id = ? and debtor_id = ?) or (debtor_id = ? and creditor_id = ?)", other, me, other, me]
    ).includes([:creditor, :debtor])
  }
  
  scope :latest_first, joins(:charge_transaction).order("charge_transactions.created_at desc")
  
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
