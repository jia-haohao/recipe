require 'rails_helper'

RSpec.describe "RailsAdmins", type: :system do
  before do
    driven_by(:rack_test)
  end
  # before { create(:user, email: 'user6@gmail.com', password: 'password1', admin: false) }
  describe '管理者の機能' do
    context '管理者はログインします' do
      let!(:user2) { create(:user2) }
      include_context "admin_login_setup"
      it '管理者はログインできます' do
        visit rails_admin_path
        expect(page).to have_content('サイト管理')
      end
    end
  end
  
  describe '普通のユーザー' do
    context '普通のユーザーは管理者を繋がらないです' do
      let!(:user) { create(:user) }
      include_context "login_setup"
      it '普通のユーザーは管理画面へ繋がれないです' do
        visit rails_admin_path
        expect(page).to have_content('サイト管理')
      end
    end
  end
end