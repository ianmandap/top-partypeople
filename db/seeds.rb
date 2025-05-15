
def create_user
  User.create(email_address: Faker::Internet.email, password: "password", display_name: Faker::Internet.user_name)
end

def create_event(user = create_user)
  Event.create(creator: user, title: Faker::Lorem.word, date: Random.rand(3..12).days.from_now, description: Faker::Lorem.paragraph, location: Faker::Lorem.word)
end

4.times { create_event }
u1 = User.create(display_name: "John", email_address: "user@example.com", password: "password")
Event.create(creator: u1, date: 7.days.from_now, location: "My house", description: "let's party!")
4.times { create_event(u1) }
