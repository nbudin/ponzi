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
  
  def chore_groups(time)
    ChoreGroup.find(:all).select do |cg|
      cg.assignee(time) == self
    end
  end
  
  def current_chore_groups()
    chore_groups(Time.new)
  end
  
  def chores(time)
    c = []
    chore_groups(time).each do |cg|
      c += cg.chores
    end
    return c
  end
  
  def current_chores()
    chores(Time.new)
  end
end
