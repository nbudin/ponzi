class Chore < ActiveRecord::Base
  has_and_belongs_to_many :chore_groups
end
