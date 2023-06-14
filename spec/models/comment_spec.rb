require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:cook) { create(:cook) }
  let(:comment) { create(:comment, cook: cook, user: user) }
  it 'レシピに属します' do
    expect(comment.cook).to eq(cook)
  end
  describe 'バリデーションのテスト' do
    context 'コメントの内容が空の場合' do
      it 'バリデーションにひっかる' do
        comment.cook = nil
        expect(comment).not_to be_valid
      end
    end
  end
end
