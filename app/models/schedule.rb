class Schedule < ActiveRecord::Base
  attr_accessible :start_at, :end_at, :member_id, :time_table_id, :date
  attr_writer :date
  belongs_to :member
  belongs_to :time_table
  delegate :date, to: :time_table, allow_nil: true, prefix: true

  def date
    time_table_date || @date
  end

end
