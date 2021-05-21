FactoryBot.define do
  factory :user do
    name { "user-①" }
    email { "user1@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :second_user, class: User do
    name { "user-②" }
    email { "user2@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :admin_user, class: User do
    name { "user-A" }
    email { "user3@mail.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }
  end
end
