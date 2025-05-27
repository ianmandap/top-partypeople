3.times { FactoryBot.create(:event) }
u1 = FactoryBot.create(:user, display_name: "John", email_address: "user@example.com")
u2 = FactoryBot.create(:user, display_name: "Maya")

e1 = FactoryBot.create(:event, creator: u1)
e2 = FactoryBot.create(:event, creator: u2)
e3 = FactoryBot.create(:event)

4.times { FactoryBot.create(:event, creator: u1) }

FactoryBot.create(:invite, event: e1, attendee: u2)
3.times { FactoryBot.create(:invite, event: e1) }
3.times { FactoryBot.create(:invite, event: e2) }
2.times { FactoryBot.create(:invite, event: e3) }
FactoryBot.create(:invite)
