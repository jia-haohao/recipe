require 'rails_helper'

RSpec.describe "ユーザー機能", type: :system do
  let!(:user2) { create(:user2) }
  let!(:user) { create(:user) }
  before do
    driven_by(:rack_test)
  end
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_registration_path
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'アカウント登録'
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
  end
  describe 'セッションのログイン機能' do
    let!(:user) { create(:user) }
    before do
      visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_button 'ログイン'
    end
    context 'ログインをした場合' do
      it 'ログインできる' do
        expect(page).to have_content 'ログインしました'
       end
      it 'ユーザーの詳細ページに行ける' do
        visit user_path(user)
        expect(page).to have_content 'User1'
        expect(page).not_to have_content 'ログイン'
      end
      it 'ユーザー編集できます' do
        visit edit_user_path(user)
        fill_in 'user_name', with: 'User3'
        click_button '更新'
        expect(page).to have_content 'User3'
      end
      it 'ユーザー削除できます' do
        visit user_path(user)
        # page.accept_alert do
        click_link '削除'
        # end
        expect(page).to have_content 'ログイン'
      end
    end
    context 'ログアウトした場合' do
      it 'ログアウトできる' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
        expect(page).not_to have_content 'マイページ'
      end
    end
  end
end
