# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create email: "tmc@gmail.com",name: "chien", password: "12345678", password_confirmation: "12345678"
User.create email: "tmc1@gmail.com",name: "tmc", password: "12345678", password_confirmation: "12345678"
User.create email: "pvt@gmail.com",name: "Duc", password: "12345678", password_confirmation: "12345678", admin: true
requests = []
20.times do
  requests << Request.new(topic: 1, content: Faker::Lorem.paragraph(2), header: Faker::Lorem.paragraph(2),
                 bill: 100, status: 3, user_id: 1)
end
Request.import! requests
Diploma.create certification:"abc", user_id: 1


