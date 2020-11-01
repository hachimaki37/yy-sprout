FactoryBot.define do
  factory :schedule_result do
    section { "第1節" }
    opponent { "FCtest" }
    match_result { "勝ち" }
    stadium { "TestStadium" }
    home_and_away { "ホーム" }
  end
end