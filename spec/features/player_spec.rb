require 'rails_helper'

RSpec.feature "/player", js: true do
  describe '選手の登録' do
    context 'adminユーザの場合' do
      let(:admin_user) { create(:admin_user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        click_on 'ログインする'
        click_on '選手紹介'
      end

      context '入力項目が正常な場合' do
        scenario '項目全てを選択して登録ができること' do
          expect(page).to have_content '登録されている選手はおりません。'
          click_on '選手を登録する'

          expect(page).to have_content '選手登録'

          fill_in 'name', with: playername = Faker::Name.name
          select '10', from: 'squad_number'
          select 'MF', from: 'position'
          attach_file 'image', "#{Rails.root}/spec/factories/images/test_pic.png"
          click_on '登録する'

          expect(page).to have_content '登録が完了しました'
          expect(page).to have_content playername
          expect(page).to have_content 10
          expect(page).to have_content 'MF'
          have_css "image[src$='test_pic.png']"
        end

        scenario '選手画像が選択されない場合' do
          expect(page).to have_content '登録されている選手はおりません。'
          click_on '選手を登録する'

          expect(page).to have_content '選手登録'

          fill_in 'name', with: playername = Faker::Name.name
          select '10', from: 'squad_number'
          select 'MF', from: 'position'
          click_on '登録する'

          expect(page).to have_content '登録が完了しました'
          expect(page).to have_content playername
          expect(page).to have_content 10
          expect(page).to have_content 'MF'
          have_css "image[src$='default.png']"
        end
      end

      context '入力項目が非正常な場合' do
        context 'バリデーションが効くこと' do
          scenario '入力項目が全て未入力の場合' do
            click_on '選手を登録する'
            expect(page).to have_content '選手登録'

            fill_in 'name', with: ''
            select '', from: 'squad_number', match: :first
            select '', from: 'position'
            click_on '登録する'

            expect(page).to have_content '選手名を入力してください'
            expect(page).to have_content '背番号を選択してください'
            expect(page).to have_content 'ポジションを選択してください'
          end

          scenario '選手名が10文字以上の場合' do
            click_on '選手を登録する'
            expect(page).to have_content '選手登録'

            fill_in 'name', with: playername = Faker::Name.name + 'スプロートテスト'
            select '10', from: 'squad_number'
            select 'MF', from: 'position'
            attach_file 'image', "#{Rails.root}/spec/factories/images/test_pic.png"
            click_on '登録する'

            expect(page).to have_content '選手名は10文字以下に設定して下さい'
          end

          scenario '選択した背番号が既に登録されている場合' do
            click_on '選手を登録する'
            expect(page).to have_content '選手登録'

            fill_in 'name', with: playername = Faker::Name.name
            select '10', from: 'squad_number'
            select 'MF', from: 'position'
            attach_file 'image', "#{Rails.root}/spec/factories/images/test_pic.png"
            click_on '登録する'

            expect(page).to have_content '登録が完了しました'
            click_on '選手を登録する'

            fill_in 'name', with: playername = Faker::Name.name
            select '10', from: 'squad_number'
            select 'DF', from: 'position'
            click_on '登録する'

            expect(page).to have_content '選択した背番号は既に使用されています'
          end
        end
      end
    end

    context 'adminユーザではない場合' do
      let(:user) { create(:user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on 'ログインする'
      end

      scenario '選手を登録するが表示されないこと' do
        click_on '選手紹介'

        expect(page).not_to have_content '選手を登録する'
      end

      context '選手登録画面にアクセスできなこと' do
        scenario 'ユーザログインしている場合' do
          visit '/players/new'

          expect(page).to have_content '権限がないためアクセスできません'
          expect(page).to have_content 'PLAYERS'
        end

        scenario 'ユーザログインしていない場合' do
          click_on 'ログアウト'
          visit '/players/new'

          expect(page).to have_content 'アカウント登録もしくはログインしてください'
          expect(page).to have_content 'ログイン'
        end
      end
    end
  end

  describe '登録選手の編集' do
    context 'adminユーザの場合' do
      let(:admin_user) { create(:admin_user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        click_on 'ログインする'
        click_on '選手紹介'
        click_on '選手を登録する'
      end

      scenario '登録選手の編集ができること' do
        expect(page).to have_content '選手登録'

        fill_in 'name', with: playername = Faker::Name.name
        select '10', from: 'squad_number'
        select 'MF', from: 'position'
        attach_file 'image', "#{Rails.root}/spec/factories/images/test_pic.png"
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        expect(page).to have_content playername
        expect(page).to have_content 10
        expect(page).to have_content 'MF'
        have_css "image[src$='test_pic.png']"

        click_on '編集'
        expect(page).to have_content '選手登録の編集'

        fill_in 'player_name', with: playername = Faker::Name.name + '新芽'
        select '15', from: 'player_squad_number'
        select 'FW', from: 'player_position'
        attach_file 'player_image', "#{Rails.root}/spec/factories/images/test_pic.png"
        click_on '登録を更新する'

        expect(page).to have_content '更新が完了しました'
        expect(page).to have_content playername
        expect(page).to have_content 15
        expect(page).to have_content 'FW'
        have_css "image[src$='test_pic.png']"
      end
    end

    context 'adminユーザではない場合' do
      let(:user) { create(:user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on 'ログインする'
      end

      scenario '選手登録の編集ができないこと' do
        click_on '選手紹介'

        expect(page).to have_content 'PLAYERS'
        expect(page).not_to have_content '編集'
      end
    end
  end

  describe '登録選手の削除' do
    context 'adminユーザの場合' do
      let(:admin_user) { create(:admin_user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        click_on 'ログインする'
        click_on '選手紹介'
        click_on '選手を登録する'
      end

      scenario '登録選手の削除ができること' do
        expect(page).to have_content '選手登録'

        fill_in 'name', with: playername = Faker::Name.name
        select '10', from: 'squad_number'
        select 'MF', from: 'position'
        attach_file 'image', "#{Rails.root}/spec/factories/images/test_pic.png"
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        expect(page).to have_content playername
        expect(page).to have_content 10
        expect(page).to have_content 'MF'
        have_css "image[src$='test_pic.png']"

        click_on '削除'
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content '削除が完了しました'
      end
    end

    context 'adminユーザではない場合' do
      let(:user) { create(:user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on 'ログインする'
      end

      scenario '登録選手の削除ができないこと' do
        click_on '選手紹介'

        expect(page).to have_content 'PLAYERS'
        expect(page).not_to have_content '削除'
      end
    end
  end
end