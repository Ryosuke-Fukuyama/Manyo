FactoryBot.define do
  factory :labelling do
    association :task, factory: :task
    association :label, factory: :label
  end
end