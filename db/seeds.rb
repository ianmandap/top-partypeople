
def create_user
  User.create!(email_address: Faker::Internet.email, password: "password", display_name: Faker::Internet.user_name)
end

def create_event(user = create_user)
  Event.create!(creator: user, title: Faker::Lorem.word, date: Random.rand(3..12).days.from_now, description: Faker::Lorem.paragraph_by_chars * 5, location: Faker::Lorem.word)
end

def create_invite(event = create_event)
  Invite.create!(event: event, attendee: create_user)
end

4.times { create_event }
u1 = User.create!(display_name: "John", email_address: "user@example.com", password: "password")
u2 = User.create!(display_name: "Maya", email_address: "maya@example.com", password: "password")

event1 = Event.create!(creator: u1, date: 7.days.from_now, location: "My house", description: "let's party!", title: "Let's go!")
event2 = Event.create!(creator: u2, date: 7.days.from_now, location: "Beach front at City", description: "Enjoying the fresh sun", title: "Cancun Getaway")
event3 = Event.create!(creator: create_user, date: 14.days.from_now, location: "AAA", description: "BBB", title: "ZZZ")

4.times { create_event(u1) }
Invite.create!(event: event1, attendee: u2)
3.times { create_invite(event1) }
3.times { create_invite(event2) }
2.times { create_invite(event3) }
create_invite
