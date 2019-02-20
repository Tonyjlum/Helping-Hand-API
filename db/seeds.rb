# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Start seeding data"
User.create(email: "tonyjlum@gmail.com", password: "greentea", first_name: "Tony", last_name: "Lum")
19.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(email: Faker::Internet.email(first_name + last_name), first_name: first_name, last_name: last_name  )
end

Event.create(coordinator_id: 1, datetime: Time.now, title: "Bowling Green Clean Up", description: "Park beautification project for Bowling Green in downtown Manhattan", max_volunteers: 10, address: "Broadway &, Whitehall St, New York, NY 10004")

Sponsor.create(email: "BillGates@bing.com", password: "blacktea", first_name: "Bill", last_name: "Gates", credit: 2000000)
Sponsor.create(email: "JeffBezos@amazon.com", password: "bluetea", first_name: "Jeff", last_name: "Bezos", credit: 1000000)

Donation.create(event_id: 1, sponsor_id: 1, amount_per_volunteer: 100 )
Donation.create(event_id: 1, sponsor_id: 2, amount_per_volunteer: 150 )


20.times do |index|
  current_user = User.find(index + 1)
  event = Event.find(1)
  donations = event.donations
  # sponsors = Sponsor.find(donation.sponsor_id)
  reduced_donations = donations.map{|s| s.amount_per_volunteer}.reduce(:+)
  current_confirm = Confirm.create(user_id: current_user.id, event_id: event.id, attend: [true, false].sample)
  if current_confirm.attend == true
    current_user.update(credit: current_user.credit + reduced_donations)
    donations.each do |d|
      sponsor = Sponsor.find(d.sponsor_id)
      sponsor.update(credit: sponsor.credit - d.amount_per_volunteer, total_donations: sponsor.total_donations + d.amount_per_volunteer)
    end
  end
end

puts "Finished seeding Data"
