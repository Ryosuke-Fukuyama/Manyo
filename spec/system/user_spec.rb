require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do

  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:second_user)
    visit new_session_path
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      example '作成したユーザーページが表示される' do
        visit new_user_path
        fill_in :user_name,                  with: "test_user"
        fill_in :user_email,                 with: "test@mail.com"
        fill_in :user_password,              with: "password"
        fill_in :user_password_confirmation, with: "password"
        click_button "アカウント登録"
        expect(page).to have_content 'test_user'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした時' do
      example 'ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content "ログインしてください"
      end
    end
  end

  describe 'セッション機能' do
    before do
      fill_in :session_email,    with: "user1@mail.com"
      fill_in :session_password, with: "password"
      click_button "ログイン"
    end
    context 'ログイン' do
      example 'できる' do
        expect(page).to have_content "ログインしました"
      end
    end
    context 'ログインすると' do
      example 'そのユーザーページに転移' do
        expect(page).to have_content "user-①のページ"
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶ時' do
      example 'タスク一覧画面に遷移' do
        id = @user1.id + 1
        visit user_path(id)
        expect(page).to have_content "期限でソート"
      end
    end
    context 'ログアウト' do
      example 'ログイン画面に転移' do
        click_link "ログアウト"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe '管理画面' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    before do
      fill_in :session_email,    with: "user3@mail.com"
      fill_in :session_password, with: "password"
      click_button "ログイン"
    end
    context '管理ユーザは管理画面にアクセス' do
      subject { page }
      example 'できる' do
        visit admin_users_path
        is_expected.to have_content "Profile index"
      end
    end
    context '管理ユーザはユーザの新規登録ができる' do
      before do
        visit new_admin_user_path
        fill_in :user_name,                  with: "test_user"
        fill_in :user_email,                 with: "test@mail.com"
        fill_in :user_password,              with: "password"
        fill_in :user_password_confirmation, with: 'password'
        click_button "別アカウント作成"
      end
      subject { page }
      it { is_expected.to have_content "test_user" }
    end
    context '管理ユーザはユーザの詳細画面にアクセスできる' do
      before do
        id = @user2.id
        visit admin_user_path(id)
      end
      subject { page }
      it { is_expected.to have_content "user-②のページ" }
    end
    context '管理ユーザはユーザの編集画面から' do
      example 'ユーザー編集できる' do
        id = @user1.id
        visit edit_admin_user_path(id)
        check '管理者'
        click_button "ロール編集完了"
        admin = first('.admin')
        expect(admin).to have_content "○"
      end
    end
    context '管理ユーザはユーザの削除をできる' do
      before do
        visit admin_users_path
        page.accept_confirm do
          link = first('.dele')
          link.click
        end
      end
      subject { page }
      it { is_expected.not_to have_content "use-①" }
    end
  end
end