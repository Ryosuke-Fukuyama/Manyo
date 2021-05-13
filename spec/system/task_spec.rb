require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task) }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      example '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        visit new_task_path
        # 2. 新規登録内容を入力する
        #    各入力欄(label)に該当する内容をfill_in（入力）する処理を書く
        fill_in 'タスク名',    with: "test_title"
        fill_in '内容', with: "test_content"
        fill_in '期限', with: '002021-05-01'

        # 3. ボタンをクリックする
        click_button "登録する"
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        # binding.irb
        expect(page).to have_content '2021-05-01'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      example '該当タスクの内容が表示される' do
        # let化したので不要
        # task = FactoryBot.create(:task, title: 'task')
        visit task_path(task.id)
        expect(page).to have_content Task.find(11)[:title]
      end
    end
  end

  describe '一覧表示機能' do
    let!(:task2) { FactoryBot.create(:second_task) }
    let!(:task3) { FactoryBot.create(:third_task) }
    before do
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      visit tasks_path
      # 変数をセットする場合は、ローカル変数ではなく、インスタンス変数にデータをセットしています。※ before ブロックと it ブロックの中では変数のスコープが異なるため。
      # allメソッドを使うことで、条件に合致した要素の配列を取得できます。
      @list_top = first('.sort')
    end
    context '一覧画面に遷移した場合' do
      subject { page }
      example '作成済みのタスク一覧が表示される' do
        # タスクデータ作成と一覧画面への遷移の記述を移動したため、ここでの記述は不要
          # テストで使用するためのタスクを作成
          # タスク一覧ページに遷移
          # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        is_expected.to have_content Task.find(11)[:title]
        is_expected.to have_content Task.find(22)[:title]
      end
    end
    context '複数のタスクを作成した場合' do
      subject { @list_top }
      # 'タスクが作成日時の降順に並んでいる'
      it { is_expected.to have_content Task.find(33)[:title] }
    end
    context '終了期限でソートするというリンクを押した場合' do
      before do
        click_link '期限でソートする'
      end
      subject { @list_top }
      it { is_expected.to have_content Task.find(22)[:title] }
    end
  end
end