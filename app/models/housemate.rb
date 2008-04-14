class Housemate < ActiveRecord::Base
  belongs_to :person
  has_many :chore_group_candidates
  has_many :chore_groups, :through => :chore_group_candidates
  
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
    b += Charge.sum('amount', :conditions => ["creditor_id = ? and debtor_id = ?", person.id, other.id])
    b -= Charge.sum('amount', :conditions => ["creditor_id = ? and debtor_id = ?", other.id, person.id])
    return b
  end
  
  def chore_groups_at(time)
    chore_groups.select do |cg|
      cg.assignee_at(time) == self
    end
  end
  
  def current_chore_groups()
    chore_groups_at(Time.new)
  end
  
  def chores_at(time)
    c = []
    chore_groups_at(time).each do |cg|
      c += cg.chores
    end
    return c
  end
  
  def current_chores()
    chores_at(Time.new)
  end
end
