class Charge < ActiveRecord::Base
  belongs_to :charge_transaction, :foreign_key => "transaction_id"
  belongs_to :creditor, :foreign_key => "creditor_id", :class_name => "Housemate"
  belongs_to :debtor, :foreign_key => "debtor_id", :class_name => "Housemate"
  composed_of :amount, :class_name => "Money", :mapping => [%w(cents cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) }
  
  scope :between, lambda { |me, other|
    where(
      ["(creditor_id = ? and debtor_id = ?) or (debtor_id = ? and creditor_id = ?)", other.id, me.id, other.id, me.id]
    ).includes([:creditor, :debtor])
  }
  
  scope :involving, lambda { |me|
    where(
      ["creditor_id = ? or debtor_id = ?", me.id, me.id]
    ).includes([:creditor, :debtor])
  }
  
  scope :latest_first, joins(:charge_transaction).order("charge_transactions.created_at desc")
  
  def balance(person)
    if person == debtor and person == creditor
      return Money.new(0)
    elsif person == debtor
      return amount * -1
    elsif person == creditor
      return amount
    else
      return Money.new(0)
    end
  end
  
  def other(person)
    if person == debtor
      return creditor
    elsif person == creditor
      return debtor
    end
  end
  
  def self.total_balance(charges, housemate)
    b = Money.new(0.0)
    charges.each do |charge|
      b += charge.balance(housemate)
    end
    return b
  end
end
