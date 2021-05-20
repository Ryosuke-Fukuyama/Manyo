require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @task2 = FactoryBot.create(:second_user)
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      example '作成したユーザーページが表示される' do
        visit new_user_path
        fill_in '',    with: "test_user"
        fill_in '',    with: "test@mail.com"
        fill_in '', with: "password"
        fill_in '', with: 'password'
        click_button ""
        expect(page).to have_content 'test_user'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      example 'ログイン画面に遷移する' do
        xpect(@user).to eq nil
      end
    end
  end

  describe 'セッション機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      example '該当タスクの内容が表示される' do
        visit task_path(@task1.id)
        expect(page).to have_content @task1[:title]
      end
    end
  end

  describe '一覧表示機能' do
    before do
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      # 変数をセットする場合は、ローカル変数ではなく、インスタンス変数にデータをセットしています。※ before ブロックと it ブロックの中では変数のスコープが異なるため。
      # allメソッドを使うことで、条件に合致した要素の配列を取得できます。
    end
    context '一覧画面に遷移した場合' do
      subject { page }
      example '作成済みのタスク一覧が表示される' do
        # タスクデータ作成と一覧画面への遷移の記述を移動したため、ここでの記述は不要
          # テストで使用するためのタスクを作成
          # タスク一覧ページに遷移
          # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
          # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        is_expected.to have_content @task2[:title]
        is_expected.to have_content @task3[:title]
      end
    end
    context '複数のタスクを作成した場合' do
      subject { @list_top }
      # 'タスクが作成日時の降順に並んでいる'
      it { is_expected.to have_content @task[:title] }
    end
    context '終了期限でソートというリンクを押した場合' do
      before do
        click_link '期限でソート'
        @list_top = first('.sort')
      end
      subject { @list_top }
      it { is_expected.to have_content @task2[:title] }
    end
    context '優先順位でソートというリンクを押した場合' do
      before do
        click_link '優先順位でソート'
        @list_top = first('.sort')
      end
      subject { @list_top }
      sleep 0.5
      it { is_expected.to have_content @task3[:title] }
    end
  end

  describe '検索' do
    context 'タイトルで検索した場合' do
      example '絞り込みできる' do
        fill_in :search_title, with: 'たいとる'
        click_button '検索する'
        expect(page).to have_content 'たいとる'
      end
    end
    context 'ステータスで検索した場合' do
      example '絞り込みできる' do
        select '着手中', from: :search_progress
        click_button '検索する'
        expect(page).to have_content '着手中'
      end
    end
    context 'タイトルとステータスの両方で検索した場合' do
      example '絞り込みできる' do
        fill_in 'タスク名', with: 'デフォルト'
        select '完了', from: 'ステータス'
        click_button '検索する'
        expect(page).to have_content @task3[:title]
      end
    end
  end
end