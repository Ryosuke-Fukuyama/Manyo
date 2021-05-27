FactoryBot.define do
  factory :label do
    name { "テストラベル1" }
  end
  factory :second_label, class: Label do
    name { "テストラベル2" }
  end
  factory :third_label, class: Label do
    name { "テストラベル3" }
  end
  factory :fourth_label, class: Label do
    name { "テストラベル4" }
  end
end
