require 'faker'

# Create Users
5.times do
  User.create!(
  email:    Faker::Internet.email,
  password: Faker::Internet.password,
  role: :standard
  )
end
users = User.all

# Create Wikis
50.times do
# #1
  wiki = Wiki.create!(
   user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph(2),
    private: false
  )

  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)

end
wikis = Wiki.all

puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
