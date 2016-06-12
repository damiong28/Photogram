=begin
# Users
User.create!(username:  "exampleuser",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username: username,
              email: email,
              password:              password,
              password_confirmation: password)
end

# Posts
users = User.order(:created_at).take(6)
50.times do
  caption = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(caption: caption) }
end
=end