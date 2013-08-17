class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :member
      t.references :time_table
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
