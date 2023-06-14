require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) { create(:user) }
  let(:followed) { create(:user2) }
  let(:relationship) { create(:relationship, follower: follower, followed: followed) }
  describe 'アソシエーションのテスト' do
    it "フォロワーに属する" do
      expect(relationship.followed).to eq(followed)
    end

    it "フォロー中に属する" do
      expect(relationship.follower).to eq(follower)
    end
  end
  describe 'バリデーションのテスト' do
    context 'タスクのフォロワーが空の場合' do
      it 'バリデーションにひっかる' do
        relationship.followed_id = nil
        expect(relationship).not_to be_valid
      end
    end
    context 'タスクのフォロー中が空の場合' do
      it 'バリデーションにひっかる' do
        relationship.follower_id = nil
        expect(relationship).not_to be_valid
      end
    end
  end
end
