class Member < ActiveRecord::Base
  attr_accessible :name, :team_id, :schedules_attributes
  belongs_to :team
  has_many :schedules
  attr_accessor :schedule_in_table

  accepts_nested_attributes_for :schedules

  def schedules_attributes=(attributes)
    attributes.values.each do |schedule|
      if schedule["id"].blank? || schedule["time_table_id"].blank?
        xtb = TimeTable.where(date: schedule["date"],
                              team_id: self.team.id)
          .first_or_create(date: schedule["date"].to_date,
                           team_id: self.team.id)
        xschedule = xtb.schedules.select{|sc| sc.member_id == self.id}.first
        schedule.merge!("id" => xschedule.try(:id),
                        "time_table_id" => xtb.id)
      end
    end
    assign_nested_attributes_for_collection_association(:schedules, attributes)
  end

  def load_schedule_in_day xday
    self.schedule_in_table = Array(self.schedules
      .select{|s| s.date == xday}.first || schedules.new(date: xday))
  end
end
