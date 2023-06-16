require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  describe 'レシピ一覧画面のテスト' do
    include_context "login_setup"
    let(:user) { create(:user) }
    let!(:user2) { create(:user2) }
    let!(:cook) { create(:cook, user: user) }
    let!(:cook2) { create(:cook, user: user2) }
    let!(:favorite) { create(:favorite, cook: cook, user: user) } # 1ついいね済にしておく
  
    before do  
      visit cooks_path
    end
  
    context 'いいね確認' do
      it 'リンクが諸々正しい' do
        expect(page).to have_link '', href: cook_favorites_path(cook) #リンクが正しい
        expect(page).to have_css('i.far') #いいねの表示
        expect(page).to have_css('i.fas') #いいね済の表示
      end
    end
  end
end
