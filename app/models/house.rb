class House < ActiveRecord::Base
  has_and_belongs_to_many :housemates, :include => [:person, :credits, :debts]
  has_many :chore_groups
end
