require 'rails_helper'

RSpec.feature "match/schedule_results", js: true do
  describe '試合日程の登録' do
    context 'adminユーザの場合' do
      let(:admin_user) { create(:admin_user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        click_on 'ログインする'
        click_on '試合日程・結果'
      end

      scenario '項目全てを選択して登録ができること' do
        click_on '試合日程を登録する'
        expect(page).to have_content '試合スケジュール登録'

        fill_in 'schedule_result_match_date_time', with: Date.yesterday
        select '第1節', from: 'schedule_result_section'
        select 'リューレント', from: 'schedule_result_opponent'
        select '勝ち', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
        expect(page).to have_content '第1節'
        expect(page).to have_content 'リューレント'
        expect(page).to have_content '◯'
        expect(page).to have_content '古々崎第1G'
        expect(page).to have_content 'ホーム'
      end

      scenario '試合日時を未入力で登録した場合、未定と表示されること' do
        click_on '試合日程を登録する'
        expect(page).to have_content '試合スケジュール登録'

        fill_in 'schedule_result_match_date_time', with: ''
        select '第2節', from: 'schedule_result_section'
        select 'サザンクロス', from: 'schedule_result_opponent'
        select '負け', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        expect(page).to have_content '未定'
        expect(page).to have_content '第2節'
        expect(page).to have_content 'サザンクロス'
        expect(page).to have_content '✕'
        expect(page).to have_content '古々崎第1G'
        expect(page).to have_content 'ホーム'
      end

      scenario '試合結果を未入力で登録した場合、未定と表示されること' do
        click_on '試合日程を登録する'
        expect(page).to have_content '試合スケジュール登録'

        fill_in 'schedule_result_match_date_time', with: Date.yesterday
        select '第3節', from: 'schedule_result_section'
        select 'ドラックス', from: 'schedule_result_opponent'
        select '', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
        expect(page).to have_content '第3節'
        expect(page).to have_content 'ドラックス'
        expect(page).to have_content '未定'
        expect(page).to have_content '古々崎第1G'
        expect(page).to have_content 'ホーム'
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

      scenario '試合日程を登録するが表示されないこと' do
        click_on '試合日程・結果'

        expect(page).to have_content '試合日程・結果'
        expect(page).not_to have_content '試合スケジュール登録'
      end

      context '試合スケジュール登録画面にアクセスできなこと' do
        scenario 'ユーザログインしている場合' do
          visit '/match/schedule_results/new'

          expect(page).to have_content '権限がないためアクセスできません'
          expect(page).to have_content '試合日程・結果'
        end

        scenario 'ユーザログインしていない場合' do
          click_on 'ログアウト'
          visit '/match/schedule_results/new'

          expect(page).to have_content 'アカウント登録もしくはログインしてください'
          expect(page).to have_content 'ログイン'
        end
      end
    end
  end

  describe '試合日程の変更' do
    context 'adminユーザの場合' do
      let(:admin_user) { create(:admin_user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        click_on 'ログインする'
        visit new_match_schedule_result_path
      end

      scenario '登録した試合日程を編集できること' do
        fill_in 'schedule_result_match_date_time', with: ''
        select '第1節', from: 'schedule_result_section'
        select 'リューレント', from: 'schedule_result_opponent'
        select '', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
        expect(page).to have_content '第1節'
        expect(page).to have_content 'リューレント'
        expect(page).to have_content '未定'
        expect(page).to have_content '古々崎第1G'
        expect(page).to have_content 'ホーム'

        click_on '編集'
        expect(page).to have_content '試合スケジュール変更'

        fill_in 'match_date_time', with: Date.yesterday
        select '第2節', from: 'section'
        select 'サザンクロス', from: 'opponent'
        select '負け', from: 'match_result'
        select '古々崎第2G', from: 'stadium'
        select 'アウェー' , from: 'home_and_away'
        click_on '更新する'

        expect(page).to have_content '更新が完了しました'
        #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
        expect(page).to have_content '第2節'
        expect(page).to have_content 'サザンクロス'
        expect(page).to have_content '✕'
        expect(page).to have_content '古々崎第2G'
        expect(page).to have_content 'アウェー'
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

      scenario '試合日程の編集ができないこと' do
        click_on '試合日程・結果'

        expect(page).to have_content '試合日程・結果'
        expect(page).to have_content '編集/削除'
        expect(page).to have_content '-'
      end
    end
  end

  describe '試合日程の削除' do
    context 'adminユーザの場合' do
      let(:admin_user) { create(:admin_user) }

      before do
        visit '/users/sign_in'
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        click_on 'ログインする'
        visit new_match_schedule_result_path
      end

      scenario '登録した試合日程を削除できること' do
        fill_in 'schedule_result_match_date_time', with: ''
        select '第1節', from: 'schedule_result_section'
        select 'リューレント', from: 'schedule_result_opponent'
        select '', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'
        #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
        expect(page).to have_content '第1節'
        expect(page).to have_content 'リューレント'
        expect(page).to have_content '未定'
        expect(page).to have_content '古々崎第1G'
        expect(page).to have_content 'ホーム'
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

      scenario '試合日程の削除ができないこと' do
        click_on '試合日程・結果'

        expect(page).to have_content '試合日程・結果'
        expect(page).to have_content '編集/削除'
        expect(page).to have_content '-'
      end
    end
  end
end
