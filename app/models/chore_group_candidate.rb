class ChoreGroupCandidate < ActiveRecord::Base
  belongs_to :housemate
  belongs_to :chore_group
  acts_as_list :scope => :chore_group
end
