require 'rails_helper'

RSpec.feature "root_path", js: true do
  describe 'NEXT MATCHが表示されること' do
    before do
      visit root_path
    end

    context 'match_resultがnilの場合' do
      scenario '最初のレコードが表示されること' do
        expect(page).to have_content '※次節の日程はありません※'

        click_on '試合日程・結果'
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

        click_on '試合日程を登録する'
        fill_in 'schedule_result_match_date_time', with: Time.zone.now
        select '第2節', from: 'schedule_result_section'
        select 'ドラックス', from: 'schedule_result_opponent'
        select '', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'アウェー' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'

        click_on '試合日程を登録する'
        fill_in 'schedule_result_match_date_time', with: Time.zone.now
        select '第3節', from: 'schedule_result_section'
        select 'サザンクロス', from: 'schedule_result_opponent'
        select '', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'

        visit root_path
        expect(page).to have_content '第2節'
        expect(page).to have_content 'ドラックス'
        expect(page).to have_content '古々崎第1G'
        expect(page).to have_content 'アウェー'
      end
    end

    context 'match_resultがtrueの場合' do
      scenario 'レコードが表示されないこと' do
        expect(page).to have_content '※次節の日程はありません※'

        click_on '試合日程・結果'
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

        click_on '試合日程を登録する'
        fill_in 'schedule_result_match_date_time', with: Time.zone.now
        select '第2節', from: 'schedule_result_section'
        select 'ドラックス', from: 'schedule_result_opponent'
        select '負け', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'アウェー' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'

        click_on '試合日程を登録する'
        fill_in 'schedule_result_match_date_time', with: Time.zone.now
        select '第3節', from: 'schedule_result_section'
        select 'サザンクロス', from: 'schedule_result_opponent'
        select '勝ち', from: 'schedule_result_match_result'
        select '古々崎第1G', from: 'schedule_result_stadium'
        select 'ホーム' , from: 'schedule_result_home_and_away'
        click_on '登録する'

        expect(page).to have_content '登録が完了しました'

        visit root_path
        expect(page).to have_content '※次節の日程はありません※'
      end
    end
  end
end
