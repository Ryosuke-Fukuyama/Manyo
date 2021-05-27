require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do

  let!(:user) {FactoryBot.create(:user) }
  let!(:task) {FactoryBot.create(:task, user: user) }
  let!(:second_task) {FactoryBot.create(:second_task, user: user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }
  let!(:third_label) { FactoryBot.create(:third_label) }
  let!(:fourth_label) { FactoryBot.create(:fourth_label) }

  before do
    visit tasks_path
    fill_in :session_email,    with: "user1@mail.com"
    fill_in :session_password, with: "password"
    click_button "ログイン"
    click_link "タスク一覧"
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      example '作成したラベル付きタスクが表示される' do
        click_link "新規投稿"
        fill_in :task_title,   with: "test_title"
        fill_in :task_content, with: "test_content"
        fill_in :task_limit,   with: "002021-05-01"
        select '完了', from: :task_progress
        check label.name
        click_button "登録する"
        expect(page).to have_content label.name
      end
    end
  end

  describe '編集' do
    context 'edit画面でチェックボックスをチェックした場合' do
      example 'ラベルが表示される' do
        id = task.id
        visit edit_task_path(id)
        check label.name
        check second_label.name
        click_button "更新する"
        expect(find_by_id("tasks-index_item-#{task.id}-label-#{label.id}")).to have_content(label.name)
        expect(find_by_id("tasks-index_item-#{task.id}-label-#{second_label.id}")).to have_content(second_label.name)
      end
    end
  end

  describe '検索' do
    before do
      id = task.id
      visit edit_task_path(id)
      check label.name
      click_button "更新する"
    end
    context '任意のラベル検索をした場合' do
      example '絞り込みできる' do
        select label.name, from: :task_label_id
        click_button '検索する'
        expect(page).to have_content "Factoryで作ったデフォルトのタイトル１"
      end
    end
  end
end