class House < ActiveRecord::Base
  has_and_belongs_to_many :housemates
  has_many :chore_groups
end
