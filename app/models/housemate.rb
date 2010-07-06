class Housemate < ActiveRecord::Base
  devise :cas_authenticatable, :trackable
  
  has_and_belongs_to_many :houses
  has_many :chore_group_candidates
  has_many :chore_groups, :through => :chore_group_candidates, :include => [:assignees]
  has_many :debts, :class_name => "::Charge", :foreign_key => 'debtor_id', :include => [:creditor, :debtor]
  has_many :credits, :class_name => "::Charge", :foreign_key => 'creditor_id', :include => [:creditor, :debtor]
  
  def cas_extra_attributes=(attrs)
    attrs.each do |key, value|
      case key.to_sym
      when :firstname
        self.firstname = value
      when :lastname
        self.lastname = value
      end
    end
  end
  
  def name
    "#{firstname} #{lastname}"
  end
  
  def balance
    Charge.total_balance(Charge.involving(self).all, self)
  end
  
  def relative_balance(other)
    Charge.total_balance(Charge.between(self, other).all, self)
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
