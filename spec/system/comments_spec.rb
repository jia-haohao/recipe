require 'rails_helper'

RSpec.describe "コメント機能", type: :system, js: true do
  # before do
  #   driven_by(:rack_test)
  # end
  let!(:user) { create(:user) }
  let!(:label1){ create(:label1) }
  let!(:label2){ create(:label2) }
  let!(:cook) { create(:cook, user: user) }
  let!(:comment){ create(:comment, user: user, cook: cook) }
  before do
    cook.labels << [label1,label2]
  end
  describe '新規作成機能' do
    include_context "login_setup"
    context 'レシピ投稿した場合' do
      it '投稿したレシピが表示される' do
        visit new_cook_path
        fill_in 'cook_title', with: 'title'
        check 'label1'
        check 'label2'
        fill_in 'cook_describe', with: 'describe'
        attach_file 'cook_image', "#{Rails.root}/spec/fixtures/no-image.png"
        click_button '登録する'
        expect(page).to have_content 'title'
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
        expect(page).to have_content 'describe'
        expect(page).to have_selector("img[src$='no-image.png']")
      end
      it 'コメントを投稿できること' do
        visit cook_path(cook)
        fill_in 'comment_content', with: 'chiba'
        click_on '登録する'
        expect(page).to have_content 'chiba'
      end
     it '自分のコメントを編集できること' do
        visit cook_path(cook)
        find('#edit').click
        fill_in 'comment_content', with: 'text'
        click_on '更新する'
        expect(page).to have_content 'text'
      end
      it '自分のコメントを削除できること' do
        visit cook_path(cook)
        page.accept_alert do
          find('#trash').click
        end
        expect(page).to have_no_content 'text, wait: 5'
      end
    end
  end
end
