# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Seeding..."
Customer.create(name: 'Mark', email: 'mark@local.com', address: 'address 1')
Customer.create(name: 'Sam', email: 'sam@local.com', address: 'address 2')
Customer.create(name: 'Terry', email: 'terry@local.com', address: 'address 3')

Court.create(name: 'Court 1', code: 'T001', kind: 'tennis')
Court.create(name: 'Court 2', code: 'T002', kind: 'tennis')
Court.create(name: 'Court 3', code: 'B001', kind: 'badminton')
Court.create(name: 'Court 4', code: 'B002', kind: 'badminton')
puts "Seeding done."