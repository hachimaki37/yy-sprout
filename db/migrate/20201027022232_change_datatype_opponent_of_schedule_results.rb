class ChangeDatatypeOpponentOfScheduleResults < ActiveRecord::Migration[5.2]
  def change
    change_column :schedule_results, :opponent, :integer
    change_column :schedule_results, :match_result, :integer
    change_column :schedule_results, :stadium, :integer
    change_column :schedule_results, :home_and_away, :integer
  end
end
