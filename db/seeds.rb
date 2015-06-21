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

user = User.first
details = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

category_ids = Category.pluck(:id)

products = Product.create!([
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '6226 10 Line, Beeton, ON L0G 1A0, Canada',
    latitude: '44.099421',
    longitude: '-79.793701',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '5423-5445 Trafalgar Road North, Hillsburgh, ON N0B 1Z0, Canada',
    latitude: '43.747289',
    longitude: '-80.079346',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '5501-5613 Countryside Drive, Brampton, ON L6P, Canada',
    latitude: '43.834527',
    longitude: '-79.689331',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '19619 McCowan Road, Mount Albert, ON L0G 1M0, Canada',
    latitude: '44.138856',
    longitude: '-79.337769',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '7588 4 Line, Wallenstein, ON N0B 2S0, Canada',
    latitude: '43.65595',
    longitude: '-80.661621',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '865 Second Line East, Sault Ste. Marie, ON P6B 4K5, Canada',
    latitude: '46.538554',
    longitude: '-84.302902',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '18 Oriole Crescent, Baltimore, ON K0K 1C0, Canada',
    latitude: '44.015904',
    longitude: '-78.147297',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: "3429-3461 Albert's Alley, Cobourg, ON K9A 4J7, Canada",
    latitude: '44.035529',
    longitude: '-78.219223',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '3054 McClelland Road, Port Hope, ON L1A 3V6, Canada',
    latitude: '44.005657',
    longitude: '-78.274155',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '3351 Dundas Street West, Toronto, ON M6P 2A6, Canada',
    latitude: '43.665419',
    longitude: '-79.481878',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '265 Runnymede Road, Toronto, ON M6S 2Y5, Canada',
    latitude: '43.651323',
    longitude: '-79.476213',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '349 Runnymede Road, Toronto, ON M6S 2Y5, Canada',
    latitude: '43.654615',
    longitude: '-79.477544',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '648 Windermere Avenue, Toronto, ON M6S 3L8, Canada',
    latitude: '43.656602',
    longitude: '-79.482737',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: '360 Armadale Avenue, Toronto, ON M6S 3X8, Canada',
    latitude: '43.653311',
    longitude: '-79.484968',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  },
  {
    title: "Nikon #{rand(10..20)}",
    price_per_day: rand(10..20),
    user_id: user.id,
    address: 'Old Weston Road, Toronto, ON M6N, Canada',
    latitude: '43.669051',
    longitude: '-79.46188',
    details: details,
    total_value: rand(200..500),
    category_id: category_ids.sample,
    tag_list: "tag#{rand(0..9)}, tag#{rand(0..9)}",
    address: 'Toronto, Canada'
  }
])

products.each do |p|
  Asset.create(image: File.new("#{Rails.root}/db/seed/slider1.png"), attachable_type: 'Product', attachable_id: p.id)
  Asset.create(image: File.new("#{Rails.root}/db/seed/slider2.png"), attachable_type: 'Product', attachable_id: p.id)
  Asset.create(image: File.new("#{Rails.root}/db/seed/slider3.jpg"), attachable_type: 'Product', attachable_id: p.id)
  Asset.create(image: File.new("#{Rails.root}/db/seed/slider4.jpg"), attachable_type: 'Product', attachable_id: p.id)
end
