# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create( email: "tonyjlum@gmail.com", password: "greentea", first_name: "Tony", last_name: "Lum")

Event.create(coordinator_id: 1, datetime: Time.now, description: "Testing first Event")
