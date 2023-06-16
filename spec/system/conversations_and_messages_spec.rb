require 'rails_helper'

RSpec.describe "チャットのメッセージ", type: :system do
  before do
    driven_by(:rack_test)
  end
  describe "チャットでメッセージ機能" do
    let(:sender) { create(:user) }
    let(:recipient) { create(:user2) }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: sender.email
      fill_in 'user_password', with: sender.password
      click_button 'ログイン'
    end

    describe "チャットで新しいメッセージを発送します" do
      let(:conversation) { create(:conversation, sender: sender, recipient: recipient) }

      it "新しいメッセージを発送します" do
        visit conversation_messages_path(conversation)
        fill_in "message_body", with: "Hello, how are you?"

        click_button "メッセージを送る"

        expect(page).to have_content("Hello, how are you?")
      end
    end

    describe "発送したメッセージは既読できます" do
      let(:conversation) { create(:conversation, sender: sender, recipient: recipient) }
      let!(:message) { create(:message, conversation: conversation, user: sender, read: false) }

      it "発送したメッセージは既読できる確認する" do
        click_link "ログアウト"
        visit new_user_session_path
        fill_in 'user_email', with: recipient.email
        fill_in 'user_password', with: recipient.password
        click_button 'ログイン'

        visit conversation_messages_path(conversation)
        message.reload

        expect(message.read).to be true
      end
    end
  end
end
