require 'rails_helper'

RSpec.describe "フォロー機能管理", type: :system do
  before do
    driven_by(:rack_test)
  end
  describe "フォロー機能" do
    include_context "login_setup"
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    context 'ユーザーをフォローする場合' do
      it 'ユーザーをフォローします' do
        visit user_path(other_user)
        click_button 'フォロー'
        expect(user.following?(other_user)).to be_truthy
      end
    end

    context 'フォローを解除することができる' do
      before do
        user.follow!(other_user)
      end

      it 'フォローしているユーザーのフォローを解除することができる' do
        visit user_path(other_user)
        click_button 'フォロー中'
        expect(page).to have_button('フォロー')
        expect(user.following?(other_user)).to be_falsey
      end
    end
  end
end

