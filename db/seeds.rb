# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.create!(
  username: 'testuser1',
  email: 'test1@mail.com',
  password: 'lenyt2015',
  password_confirmation: 'lenyt2015')
u2 = User.create!(
  username: 'testuser2',
  email: 'test2@mail.com',
  password: 'lenyt2015',
  password_confirmation: 'lenyt2015')
u3 = User.create!(
  username: 'testuser3',
  email: 'test3@mail.com',
  password: 'lenyt2015',
  password_confirmation: 'lenyt2015')

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
