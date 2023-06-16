require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザーの名前が空の場合' do
      it 'バリデーションにひっかる' do
        user = User.new(name: '', email: 'user@user.com', password: 'abcdef')
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレスが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'テスト', email: '', password: 'abcdef')
        expect(user).not_to be_valid
      end
    end
  end
  describe 'ユーザ登録のテスト' do
    let!(:user) { create(:user) }
    context 'ユーザーについて' do
      it '新規登録ができる' do
        expect(user).to be_valid
      end
    end
  end
end
