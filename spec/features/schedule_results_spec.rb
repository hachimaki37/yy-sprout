require 'rails_helper'

RSpec.feature "match/schedule_results", js: true do
  describe '試合日程の登録ができること' do
    before do
      visit root_path
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
      click_on '試合日程を登録する'

      expect(page).to have_content '投稿が完了しました'
      #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
      expect(page).to have_content '第1節'
      expect(page).to have_content 'リューレント'
      expect(page).to have_content '◯( 第1節 ー 第1節 )'
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
      click_on '試合日程を登録する'

      expect(page).to have_content '投稿が完了しました'
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
      click_on '試合日程を登録する'

      expect(page).to have_content '投稿が完了しました'
      #TODO: match_date_timeのテストを追加する（秒数がずれてテストがfailedになる）
      expect(page).to have_content '第3節'
      expect(page).to have_content 'ドラックス'
      expect(page).to have_content '未定'
      expect(page).to have_content '古々崎第1G'
      expect(page).to have_content 'ホーム'
    end
  end
end
