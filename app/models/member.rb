class Member < ActiveRecord::Base
  attr_accessible :name, :team_id, :schedules_attributes
  belongs_to :team
  has_many :schedules

  # This attr is using to call the schedule of TimeTable through member
  attr_accessor :schedule_in_table

  accepts_nested_attributes_for :schedules

  # Rewrite the setter of nested attributes at middle object
  def schedules_attributes=(attributes)
    # This is the only one logic block
    attributes.values.each do |schedule|
      if schedule["id"].blank? || schedule["time_table_id"].blank?
        # Rescue errors of creating parent object here
        xtb = TimeTable.where(date: schedule["date"],
                              team_id: self.team.id)
          .first_or_create(date: schedule["date"].to_date,
                           team_id: self.team.id)
        # reject this current set of objects here, then next
        next unless xtb
        xschedule = xtb.schedules.select{|sc| sc.member_id == self.id}.first
        schedule.merge!("id" => xschedule.try(:id),
                        "time_table_id" => xtb.id)
      end
    end
    # Call this method for a has_many association
    assign_nested_attributes_for_collection_association(:schedules, attributes)
    # Call assign_nested_attributes_for_one_on_one_association if has_one
    # Refs: lib/activerecord/nested_attributes.rb:333
  end

  # The initializer that called from the initializer of middle object
  # to load children objects
  def load_schedule_in_day xday
    self.schedule_in_table = Array(self.schedules
      .select{|s| s.date == xday}.first || schedules.new(date: xday))
  end
end
