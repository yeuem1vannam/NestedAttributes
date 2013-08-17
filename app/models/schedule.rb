class Schedule < ActiveRecord::Base
  attr_accessible :start_at, :end_at, :member_id, :time_table_id, :date
  # Use attr_writter here
  # :date is value that use to map TimeTable with Schedule
  # This writer use 'write_attribute' macro of Rails
  attr_writer :date
  belongs_to :member
  belongs_to :time_table
  delegate :date, to: :time_table, allow_nil: true, prefix: true

  # Use instance getter date instead of attr_reader
  # If use both date and date= are instance methods, the error
  # 'Cannot modify has_many...through association' seem not to be passed
  # in some cases.
  def date
    time_table_date || @date
  end

end
