class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :tournament
      t.string :name

      t.timestamps
    end
  end
end
