class ChoreGroup < ActiveRecord::Base
  belongs_to :house
  has_and_belongs_to_many :chores
  has_many :chore_group_candidates
  has_many :assignees, :through => :chore_group_candidates, :source => :housemate,
    :order => :position
  belongs_to :initial_assignee, :class_name => "Housemate", :foreign_key => :initial_assignee_id
  
  def assignee_at(time)
    def month_num(t)
      return t.year * 12 + t.month
    end
    
    if assignees.length == 0
      return nil
    end
   
    initial_month_num = month_num(initial_assignment_time)
    current_month_num = month_num(time)
    
    current_index = (current_month_num - initial_month_num) % assignees.length
    return assignees[current_index]
  end
  
  def current_assignee()
    return assignee_at(Time.new)
  end
end
