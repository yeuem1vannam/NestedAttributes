# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Schedule.destroy_all
Member.destroy_all
Team.destroy_all
TimeTable.destroy_all
Tournament.destroy_all

puts "Create new Tournaments"
Tournament.create name: "David Cup"

puts "Create new Team"
Team.create name: "USA", tournament_id: Tournament.all.sample.id

puts "Create new Member"
Member.create name: "Andre AGASSI", team_id: Team.first.id
Member.create name: "Fred ALEXANDER", team_id: Team.first.id

puts "Create new TimeTable"
TimeTable.create date: Date.today, team_id: Team.first.id
puts "Crate new Schedule"
Schedule.create member_id: Member.first.id, time_table_id: TimeTable.first.id, start_at: Time.now, end_at: 2.hour.from_now
