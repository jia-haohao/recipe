#### User 
5.times do |n|
  User.create!(
            name: "user#{n +1}",
            email: "user#{n +1}@example.com",
            password:  "password",
            password_confirmation: "password",
            admin: [true, false].shuffle.first
  )
end

#### Label 
10.times do |n|
  name = Faker::Job.unique.field
  Label.create!( name: name )
end

#### Cook 
Cook.create!(
  user_id: User.ids.sample,
  title: "一人鍋",
  label_ids: Label.ids.sample(rand(1..3)),
  describe: "材料:.., 作り方:...!",
  image: File.open("app/assets/images/hotpot.png")
)
Cook.create!(
  user_id: User.ids.sample,
  title: "長芋のにんにく醤油漬け",
  label_ids: Label.ids.sample(rand(1..3)),
  describe: "材料:.., 作り方:...!",
  image: File.open("app/assets/images/long.jpg")
)
Cook.create!(
  user_id: User.ids.sample,
  title: "ステーキ",
  label_ids: Label.ids.sample(rand(1..3)),
  describe: "材料:.., 作り方:...!",
  image: File.open("app/assets/images/steak.png")
)
Cook.create!(
  user_id: User.ids.sample,
  title: "なす",
  label_ids: Label.ids.sample(rand(1..3)),
  describe: "材料:.., 作り方:...!",
  image: File.open("app/assets/images/maotai.jpg")
)
Cook.create!(
  user_id: User.ids.sample,
  title: "ラーメン",
  label_ids: Label.ids.sample(rand(1..3)),
  describe: "材料:.., 作り方:...!",
  image: File.open("app/assets/images/noodles.jpg")
)
Cook.create!(
  user_id: User.ids.sample,
  title: "茶巾煮",
  label_ids: Label.ids.sample(rand(1..3)),
  describe: "材料:.., 作り方:...!",
  image: File.open("app/assets/images/tofu.jpg")
)

##### Comment
Cook.all.each do |cook|
  cook.comments.create!(
    user_id: User.ids.sample,
    cook_id: cook.id,
    content: 'これは美味しいですね!'
  )
end

# ##### Relationship
users = User.first(5)
users.each do |follower|
  users.sample(2).each do |followed|
    next if follower == followed

    # Check if the relationship already exists before creating it
    unless Relationship.exists?(follower_id: follower.id, followed_id: followed.id)
      Relationship.create(
        follower_id: follower.id,
        followed_id: followed.id
      )
    end
  end
end

##### Conversations
# users = User.first(5)
# users.each do |sender|
#   users.each do |recipient|
#     next if sender == recipient

#     Conversation.create(
#       sender_id: sender.id,
#       recipient_id: recipient.id
#     )
#   end
# end

# Messages
# conversations = Conversation.first(5)
# users = User.first(5)
# conversations.each do |conversation|
#   3.times do |i|
#     user = users.sample
#     Message.create(
#       body: "メッセージ#{i + 1} (#{user.name})",
#       conversation_id: conversation.id,
#       user_id: user.id,
#       read: [true, false].sample
#     )
#   end
# end