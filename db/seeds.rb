
def create_user
  User.create(email_address: Faker::Internet.email, password: "password", display_name: Faker::Internet.user_name)
end

def create_event
  Event.create(creator: create_user, date: Random.rand(3..12).days.from_now, description: Faker::Lorem.paragraph, location: Faker::Lorem.paragraph)
end

4.times { create_event }
u1 = User.create(display_name: "John", email_address: "example@example.com", password: "password")
Event.create(creator: u1, date: 7.days.from_now, location: "My house", description: "let's party!")
