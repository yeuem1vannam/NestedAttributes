class Tournament < ActiveRecord::Base
  attr_accessible :name
  has_many :teams
end
