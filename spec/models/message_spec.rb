require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:conversation) { create(:conversation) }
  let(:user) { create(:user) }
  let(:message) { create(:message, conversation: conversation, user: user) }

  describe "アソシエーションのテスト" do
    it "会話関連に属する" do
      expect(message.conversation).to eq(conversation)
    end

    it "ユーザーに属する" do
      expect(message.user).to eq(user)
    end
  end

  describe "バリデーションのテスト" do
    it "バリデーションにひっかる" do
      expect(message).to be_valid
    end

    it "内容が空時に" do
      message.body = nil
      expect(message).not_to be_valid
    end

    it "会話関連がない時" do
      message.conversation_id = nil
      expect(message).not_to be_valid
    end

    it "ユーザーではない時" do
      message.user_id = nil
      expect(message).not_to be_valid
    end
  end

  describe "#message_time" do
    it "送信時の時間です" do
      formatted_time = message.created_at.strftime("%m/%d/%y at %l:%M %p")
      expect(message.message_time).to eq(formatted_time)
    end
  end
end

