class ChoreGroup < ActiveRecord::Base
  has_and_belongs_to_many :chores
  belongs_to :initial_assignee, :class_name => "Housemate", :foreign_key => :initial_assignee_id
  
  def assignee(time)
    def month_num(t)
      return t.year * 12 + t.month
    end
    housemates = Housemate.find :all
    initial_index = housemates.index(initial_assignee)
    
    initial_month_num = month_num(initial_assignment_time)
    current_month_num = month_num(time)
    
    current_index = (initial_index + (current_month_num - initial_month_num)) % housemates.length
    return housemates[current_index]
  end
  
  def current_assignee()
    return assignee(Time.new)
  end
end
