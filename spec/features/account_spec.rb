require 'rails_helper'

RSpec.feature "新規アカウント登録・ログイン", js: true do
  describe '新規アカウント登録' do
    context '入力項目が正常な場合' do
      before do
       visit root_path
       click_on '新規アカウント登録'
      end

      scenario '全項目を入力してアカウント登録できること' do
        expect(page).to have_content '新規アカウント登録'

        fill_in 'user_nickname', with: nickname = Faker::Name.name
        fill_in 'user_email', with: Faker::Internet.email
        fill_in 'user_password', with: password = Faker::Internet.password(min_length: 8)
        fill_in 'user_password_confirmation', with: password
        click_on 'アカウントを登録する'

        expect(page).to have_content 'アカウント登録が完了しました'
        expect(page).to have_content "現在 #{nickname} でログイン中"
      end
    end

    context '入力項目が非正常な場合' do
      before do
        visit root_path
        click_on '新規アカウント登録'
      end

      context 'バリデーションが効くこと' do
        scenario '入力項目が全て未入力の場合' do
          expect(page).to have_content '新規アカウント登録'

          fill_in 'user_nickname', with: ''
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: ''
          fill_in 'user_password_confirmation', with: ''
          click_on 'アカウントを登録する'

          expect(page).to have_content 'ニックネーム が入力されていません'
          expect(page).to have_content 'メールアドレス が入力されていません'
          expect(page).to have_content 'パスワード が入力されていません'
        end

        scenario '入力項目の名前がnilの場合' do
          expect(page).to have_content '新規アカウント登録'

          fill_in 'user_nickname', with: ''
          fill_in 'user_email', with: Faker::Internet.email
          fill_in 'user_password', with: password = Faker::Internet.password(min_length: 8)
          fill_in 'user_password_confirmation', with: password
          click_on 'アカウントを登録する'

          expect(page).to have_content 'ニックネーム が入力されていません'
        end

        scenario '入力項目のemailがnilの場合' do
          expect(page).to have_content '新規アカウント登録'

          fill_in 'user_nickname', with: nickname = Faker::Name.name
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: password = Faker::Internet.password(min_length: 8)
          fill_in 'user_password_confirmation', with: password
          click_on 'アカウントを登録する'

          expect(page).to have_content 'メールアドレス が入力されていません'
        end

        scenario '入力項目のpasswordがnilの場合' do
          expect(page).to have_content '新規アカウント登録'

          fill_in 'user_nickname', with: nickname = Faker::Name.name
          fill_in 'user_email', with: Faker::Internet.email
          fill_in 'user_password', with: ''
          fill_in 'user_password_confirmation', with: Faker::Internet.password(min_length: 8)
          click_on 'アカウントを登録する'

          expect(page).to have_content 'パスワード が入力されていません'
          expect(page).to have_content '確認用パスワード が内容とあっていません'
        end

        scenario '入力項目のpasswordとpassword_confirmationが異なる場合' do
          expect(page).to have_content '新規アカウント登録'

          fill_in 'user_nickname', with: nickname = Faker::Name.name
          fill_in 'user_email', with: Faker::Internet.email
          fill_in 'user_password', with: Faker::Internet.password(min_length: 8)
          fill_in 'user_password_confirmation', with: Faker::Internet.password(min_length: 8)
          click_on 'アカウントを登録する'

          expect(page).to have_content '確認用パスワード が内容とあっていません'
        end
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }

    before do
      visit '/users/sign_in'
    end

    scenario 'ログインできること' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'ログインする'

      expect(page).to have_content 'ログインしました'
      expect(page).to have_content "現在 #{user.nickname} でログイン中"
    end

    scenario 'ログイン済みの場合' do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'ログインする'

      expect(page).to have_content 'ログインしました'
      expect(page).to have_content "現在 #{user.nickname} でログイン中"

      visit '/users/sign_in'
      expect(page).to have_content 'すでにログインしています'
    end
  end

  describe 'ログアウト' do
    let(:user) { create(:user) }

    before do
      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'ログインする'
    end

    scenario 'ログアウトできること' do
      expect(page).to have_content 'ログインしました'
      expect(page).to have_content "現在 #{user.nickname} でログイン中"

      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
      expect(page).not_to have_content "現在 #{user.nickname} でログイン中"
    end
  end
end
