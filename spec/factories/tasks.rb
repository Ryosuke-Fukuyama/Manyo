# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    limit { '2021-06-02' }
    progress { '未着手' }
    priority { 1 }
    association :user, factory: :user
    # after(:build) do |task|
    #   label = create(:label)
    #   task.labellings << build(:labelling, task: task, label: label)
    # end
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    limit { '2021-06-03' }
    progress { '着手中' }
    priority { 0 }
    # association :user, factory: :user
  end
  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル3' }
    content { 'Factoryで作ったデフォルトのコンテント3' }
    limit { '2021-06-01' }
    progress { '完了' }
    priority { 0 }
    # association :user, factory: :user
  end
  factory :task_task, class: Task do
    title { 'でふぉるとのたいとる' }
    content { 'でふぉるとのこんてんと' }
    limit { '2021-05-01' }
    priority { 2 }
    # association :user, factory: :user
  end
end
