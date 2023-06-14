require 'rails_helper'

RSpec.describe "レシピ管理機能", type: :system do
  before do
    driven_by(:rack_test)
  end
  let!(:user) { create(:user) }
  let!(:label1){ create(:label1) }
  let!(:label2){ create(:label2) }
  # let!(:comment){ create(:comment, user: user, cook: cook) }
  let!(:cook) { create(:cook, user: user) }
  # let(:image_path) { File.join(Rails.root, 'spec/fixtures/no-image.png') }
  # let(:image) { Rack::Test::UploadedFile.new(image_path) }
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
    end
    context 'レシピのタイトルで検索する場合' do
      it '検索結果に表示される' do
        visit cooks_path(cook)
        fill_in 'q_title_cont', with: 'test1'
        click_button '検索'
        expect(page).to have_content 'test1'
      end
    end
    context 'レシピの特色で検索する場合' do
      it '検索結果に表示される' do
        visit cooks_path(cook)
        fill_in 'q_labels_name_cont', with: 'label1'
        click_button '検索'
        expect(page).to have_content 'label1'
      end
    end
    context 'レシピの詳細画面' do
      it 'レシピを編集できる' do
        visit edit_cook_path(cook)
        # binding.irb
        fill_in 'cook[title]', with: 'title1'
        click_button '更新する'
        expect(page).to have_content 'title1'
      end
    end
    context 'レシピを編集画面' do 
      it 'レシピを削除できる' do
        visit cook_path(cook)
        click_on '削除'
        expect(page).to have_content 'レシピを削除しました。'
      end
    end
  end
end
