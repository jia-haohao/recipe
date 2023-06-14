require 'rails_helper'

RSpec.describe "RailsAdmins", type: :system do
  before do
    driven_by(:rack_test)
  end
  # before { create(:user2, email: 'second@gmail.com', password: 'password2', admin: true) }
  let!(:user2) { create(:user2) }
  describe '管理者の機能' do
    context '管理者はログインします' do
      include_context "admin_login_setup"
      it '管理者はログインできます' do
        visit rails_admin_path
        expect(page).to have_content('サイト管理')
      end
    end
  end
end
