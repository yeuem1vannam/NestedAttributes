class TimeTable < ActiveRecord::Base
  attr_accessible :date, :team_id, :members_attributes
  belongs_to :team
  has_many :schedules
  # This association is the reason that make those associations to be complicated
  has_many :members, through: :team

  # Regist the nested_attributes for middle objects,
  # that through a has_many assiciation
  accepts_nested_attributes_for :members

  # The initializer that be called from controller to load middle object
  def members_with_schedule *xmember_ids
    xmembers = members.where(id: xmember_ids)
    xmembers.each do |member|
      member.load_schedule_in_day self.date
    end
    xmembers
  end
end
