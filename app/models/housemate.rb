class Housemate < ActiveRecord::Base
  belongs_to :person
  
  def balance
    b = 0.0
    charges = Charge.find_by_sql(["select * from charges where creditor_id = ? or debtor_id = ?",
      person, person])
    charges.each do |charge|
      b += charge.balance(person)
    end
    return b
  end
  
  def relative_balance(other)
    b = 0.0
    charges = Charge.find_by_sql(["select * from charges where (creditor_id = ? and debtor_id = ?) or (debtor_id = ? and creditor_id = ?)",
      other, person, other, person])
    charges.each do |charge|
      b += charge.balance(person)
    end
    return b
  end
end
