require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーションのテスト' do
    subject { favorite.valid? }

    let!(:other_favorite) { create(:favorite) }
    let(:favorite) { build(:favorite) }

    context '1User 1Cook 1いいね' do
      it 'あるUserが同じCookにいいね出来ないこと' do
        favorite.user = other_favorite.user
        favorite.cook = other_favorite.cook
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Cookモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:cook).macro).to eq :belongs_to
      end
    end
  end
end
