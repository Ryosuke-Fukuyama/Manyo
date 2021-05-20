FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
  factory :second_user, class: User do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
  factory :third_user, class: User do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end
