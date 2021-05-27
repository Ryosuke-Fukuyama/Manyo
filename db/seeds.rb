# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "admin_user",
             email: "admin_user@fmail.com",
             password: "password",
             admin: true
            )

User.create!(name: "test_user",
             email: "test_user@fmail.com",
             password: "password",
             admin: false
            )

8.times do |n|
  name = Faker::Games::LeagueOfLegends.champion
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password
              )
end

User.eager_load(:tasks).all.each do |user|
  10.times do |n|
    Task.create!(title: "テスト#{n + 1}",
                 content: "テストコンテント#{n + 1}",
                 # limit: .sample,
                 # progress: ["未着手", "着手中", "完了"].sample,
                 # priority: "",
                 user_id: user.id
                )
  end
end

10.times do |n|
  Label.create!(id: "#{n + 1}", name: "テストラベル#{n + 1}",)
end