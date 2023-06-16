require 'rails_helper'

RSpec.describe Cook, type: :model do
  describe "アソシエーションのテスト" do
    let(:user) { create(:user) }
    let(:cook) { create(:cook, user: user) }
    it "ユーザーに属する" do
      expect(cook.user).to eq(user)
    end
  end
  describe 'バリデーションのテスト' do
    context 'レシピのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        cook = Cook.new(title: '', describe: 'これはいいです', image: 'no-image.png')
        expect(cook).not_to be_valid
      end
    end
    context 'レシピの作り方が空の場合' do
      it 'バリデーションにひっかる' do
        cook = Cook.new(title: 'test', describe: '', image: 'no-image.png')
        expect(cook).not_to be_valid
      end
    end
    context 'レシピの画像が空の場合' do
      it 'バリデーションにひっかる' do
        cook = Cook.new(title: 'test', describe: 'これはいいです', image: '')
        expect(cook).not_to be_valid
      end
    end
  end
end
