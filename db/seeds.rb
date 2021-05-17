User.create!(
  name: "ゲスト",
  email: "guest00@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  activated: true
)

5.times do |n|
  name = Faker::Name.name
  email = "example_#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true
  )
end

users = User.order(:created_at).take(6)
50.times do
  text = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(text: text) }
end
