FactoryBot.create(:event, :past)
u1 = FactoryBot.create(:user, display_name: "John", email_address: "user@example.com")
u2 = FactoryBot.create(:user, display_name: "Maya")

e1 = FactoryBot.create(:event, creator: u1)
e2 = FactoryBot.create(:event, creator: u2)
e3 = FactoryBot.create(:event)

FactoryBot.create_list(:event, 4, creator: u1)

FactoryBot.create(:invite, event: e1, attendee: u2)
FactoryBot.create_list(:invite, 3, event: e1)
FactoryBot.create_list(:invite, 3, event: e2)
FactoryBot.create_list(:invite, 2, event: e3)
FactoryBot.create(:invite, attendee: u1)

# past events
# as creator
FactoryBot.create_list(:event, 2, :past, creator: u1)

# as attendee
pe1 = FactoryBot.create(:event, :past, creator: u2)
FactoryBot.create(:invite, attendee: u1, event: pe1)
