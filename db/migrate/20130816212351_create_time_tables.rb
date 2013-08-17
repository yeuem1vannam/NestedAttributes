class CreateTimeTables < ActiveRecord::Migration
  def change
    create_table :time_tables do |t|
      t.references :team
      t.date :date

      t.timestamps
    end
  end
end
