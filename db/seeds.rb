
require 'faker'

Ferment.destroy_all
User.destroy_all

10.times do |i|
  user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "users_#{i + 1}@gmail.com", password: "1234567")
  user.save
end
puts "created Users"
