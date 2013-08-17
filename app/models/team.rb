class Team < ActiveRecord::Base
  attr_accessible :name, :tournament_id
  belongs_to :tournament
  has_many :members
end
