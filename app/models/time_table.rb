class TimeTable < ActiveRecord::Base
  attr_accessible :date, :team_id, :members_attributes
  belongs_to :team
  has_many :schedules
  has_many :members, through: :team

  accepts_nested_attributes_for :members

  def members_with_schedule *xmember_ids
    xmembers = members.where(id: xmember_ids)
    xmembers.each do |member|
      member.load_schedule_in_day self.date
    end
    xmembers
  end
end
