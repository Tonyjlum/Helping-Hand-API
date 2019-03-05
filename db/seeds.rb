# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Start seeding data"
User.create(email: "tonyjlum@gmail.com", password: "greentea", first_name: "Tony", last_name: "Lum")

User.create(email: "123", password: "123", first_name: "Test", last_name: "Subject")

28.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(email: Faker::Internet.email(first_name + last_name), first_name: first_name, last_name: last_name  )
end

Sponsor.create(email: "BillGates@bing.com", password: "blacktea", first_name: "Bill", last_name: "Gates", credit: 2000000)
Sponsor.create(email: "JeffBezos@amazon.com", password: "yellowtea", first_name: "Jeff", last_name: "Bezos", credit: 1000000)
Sponsor.create(email: "MarkZuckerberg@facebook.com", password: "bluetea", first_name: "Mark", last_name: "Zuckerberg", credit: 800000)
Sponsor.create(email: "MichaelBloomberg@nyc.gov", password: "coffee", first_name: "Michael", last_name: "Bloomberg", credit: 40000)

#setting Data for first Event
Event.create(coordinator_id: 1, datetime: Faker::Time.backward(30, :afternoon), title: "Bowling Green Clean Up", description: "Park beautification project for Bowling Green in downtown Manhattan", max_volunteers: 20, address: "Broadway &, Whitehall St, New York, NY 10004", lat: 40.704060, long: -74.013220 )
Donation.create(event_id: 1, sponsor_id: 1, amount_per_volunteer: 100 )
Donation.create(event_id: 1, sponsor_id: 2, amount_per_volunteer: 150 )

20.times do |index|
  current_user = User.find(index + 1)
  event = Event.find(1)
  donations = event.donations
  # sponsors = Sponsor.find(donation.sponsor_id)
  reduced_donations = donations.map{|s| s.amount_per_volunteer}.reduce(:+)
  current_confirm = Confirm.create(user_id: current_user.id, event_id: event.id, attend: [true, true, false].sample)
  if current_confirm.attend == true
    current_user.update(credit: current_user.credit + reduced_donations)
    donations.each do |d|
      sponsor = Sponsor.find(d.sponsor_id)
      sponsor.update(credit: sponsor.credit - d.amount_per_volunteer, total_donations: sponsor.total_donations + d.amount_per_volunteer)
    end
  end
end

#setting Data for second Event
Event.create(coordinator_id: 1, datetime: Faker::Time.backward(30, :afternoon), title: "Holy Apostles Soup Kitchen Volunteer", description: "Soup kitchen that will feed 2000 new yorkers today.", max_volunteers: 14, address: "296 9th Ave, New York, NY 10001", lat: 40.758230, long: -73.992750)

second_event_spoonsors = (1..Sponsor.all.count).to_a.shuffle

2.times do
  Donation.create(event_id: 2, sponsor_id: second_event_spoonsors.pop, amount_per_volunteer: (25..200).to_a.sample)
end

20.times do |index|
  current_user = User.find(index + 1)
  event = Event.find(2)
  donations = event.donations
  # sponsors = Sponsor.find(donation.sponsor_id)
  reduced_donations = donations.map{|s| s.amount_per_volunteer}.reduce(:+)
  current_confirm = Confirm.create(user_id: current_user.id, event_id: event.id, attend: [true, true, false].sample)
  if current_confirm.attend
    current_user.update(credit: current_user.credit + reduced_donations)
    donations.each do |d|
      sponsor = Sponsor.find(d.sponsor_id)
      sponsor.update(credit: sponsor.credit - d.amount_per_volunteer, total_donations: sponsor.total_donations + d.amount_per_volunteer)
    end
  end
end

Event.create(coordinator_id: 2, datetime: Faker::Time.backward(30, :afternoon), title:"It's My Park at Battery Park", description:"This It's My Park season, volunteer with Battery Park Volunteers to clean and mulch garden beds at Battery Park. We look forward to cleaning up the park with you!", max_volunteers: 30, lat: 40.705508, long: -74.018312, address: "Battery Park, New York, 10024" )
Confirm.create(user_id: 2, event_id: 4)

# #Mass faker
# 10.times do |index|
#   Event.create(coordinator_id: (1..4).to_a.sample, datetime: Faker::Time.backward(30, :afternoon), title: " Tutoring#{index + 3}", description: "Tutoring new incoming Flatiron students", max_volunteers: (10..20).to_a.sample, address: "11 Broadway 2nd Floor, New York, NY 10004")
# end
#
# 25.times do
#   event_id = nil
#   event_sponsors = nil
#   sponsor_id = nil
#
#   until sponsor_id
#     event_id = (3..Event.all.count).to_a.sample
#     event_sponsors = Event.find(event_id).donations.map{|d| d.sponsor_id}
#     sponsor_id = ((1..Sponsor.all.count).to_a - event_sponsors).sample
#   end
#
#   Donation.create(event_id: event_id, sponsor_id: sponsor_id, amount_per_volunteer: (25..200).to_a.sample)
# end
#
# #not including event 1 and event 2
# total_volunteers = Event.all.map{ |event| event.max_volunteers}[2..-1].reduce(:+) - 1
#
# #Seeding Confirms
# total_volunteers.times do |index|
#   event_id = nil
#   event_users = nil
#   user_id = nil
#
#   until user_id != [] && user_id != nil
#     event_id = (3..Event.all.count).to_a.sample
#     event_volunteers = Event.find(event_id).confirms.map{|c| c.user_id}
#     user_id = ((1..User.all.count).to_a - event_volunteers).sample
#   end
#
#   current_confirm = Confirm.create(user_id: user_id, event_id: event_id, attend: [true, true, false].sample)
#   donations = Event.find(current_confirm.event_id).donations
#
#   #reduce donations cant be blank or else it fails
#   reduced_donations = donations.map{|s| s.amount_per_volunteer}.reduce(0){|start, num| start + num }
#
#   if current_confirm.attend
#     current_user = User.find(current_confirm.user_id)
#     current_user.update(credit: current_user.credit + reduced_donations)
#     donations.each do |d|
#       sponsor = Sponsor.find(d.sponsor_id)
#       sponsor.update(credit: sponsor.credit - d.amount_per_volunteer, total_donations: sponsor.total_donations + d.amount_per_volunteer)
#     end
#   end
#
# end
#
Event.create(
  coordinator_id: 1,
  datetime: Faker::Time.backward(30, :afternoon),
  title: "Lavender Field on Governors Island",
  description: "Community service: mural  painting project. Art skills not required",
  max_volunteers: 23,
  address: "Governors IslandNew York, NY 11231" ,
  lat:40.6895,
  long: -74.0168)
Confirm.create(user_id: 1, event_id: 4)

Event.create(
  coordinator_id: 1,
  datetime: Faker::Time.backward(30, :afternoon),
  title: "Animal Care Centers of NYC",
  description: "Come down to the ACC to help give our little creatures a bath, maybe even adopt one of your own",
  max_volunteers: 14,
  address:"110 Wall St #2, New York, NY 10005",
  lat:40.704910,
  long:-74.006350)

Sponsor.create(email: "m", password: "m", first_name: "Dolla", last_name: "Bills", credit: 2000000)

puts "Finished seeding Data"
