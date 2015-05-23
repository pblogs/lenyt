# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.first
u2 = User.find 3
u3 = User.find 4

u2.send_message(u1, Faker::Lorem.sentence(4, true, 4), 'new request')
conversation = u2.mailbox.conversations.first

15.times do
  u1.reply_to_conversation(conversation, Faker::Lorem.sentence(4, true, 4))
  u2.reply_to_conversation(conversation, Faker::Lorem.sentence(4, true, 4))
end

u3.send_message(u1, Faker::Lorem.sentence(4, true, 4), 'new request')
conversation = u3.mailbox.conversations.first

10.times do
  u1.reply_to_conversation(conversation, Faker::Lorem.sentence(4, true, 4))
  u3.reply_to_conversation(conversation, Faker::Lorem.sentence(4, true, 4))
end
