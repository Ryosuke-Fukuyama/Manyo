require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user1 = FactoryBot.create(:user)
    @task =  FactoryBot.create(:task_task, user: @user1)
    @task1 = FactoryBot.create(:task, user: @user1)
    @task2 = FactoryBot.create(:second_task, user: @user1)
    @task3 = FactoryBot.create(:third_task, user: @user1)
    visit tasks_path
    fill_in :session_email,    with: "user1@mail.com"
    fill_in :session_password, with: "password"
    click_button "ログイン"
    click_link "タスク一覧"
    @list_top = first('.sort')
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      example '作成したタスクが表示される' do
        click_link "新規投稿"
        fill_in :task_title,   with: "test_title"
        fill_in :task_content, with: "test_content"
        fill_in :task_limit,   with: "002021-05-01"
        select '完了', from: :task_progress
        click_button "登録する"
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_content'
        expect(page).to have_content '2021-05-01'
        expect(page).to have_content '完了'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      example '該当タスクの内容が表示される' do
        visit task_path(@task1.id)
        expect(page).to have_content @task1[:title]
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      subject { page }
      example '作成済みのタスク一覧が表示される' do
        is_expected.to have_content @task2[:title]
        is_expected.to have_content @task3[:title]
      end
    end
    context '複数のタスクを作成した場合' do
      subject { @list_top }
      it { is_expected.to have_content @task[:title] }
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
        fill_in :search_title, with: 'デフォルト'
        select '完了', from: :search_progress
        click_button '検索する'
        expect(page).to have_content @task3[:title]
      end
    end
  end
end