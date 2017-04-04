require 'faker'

#create users
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    confirmed_at: Time.now
  )
end
users = User.all
# Create items
50.times do
  Wiki.create!(
    title: Faker::Book.title,
    body: Faker::Book.author,
    private: false,
    user: users.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} items created"
