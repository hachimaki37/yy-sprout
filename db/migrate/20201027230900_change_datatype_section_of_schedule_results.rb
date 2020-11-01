class ChangeDatatypeSectionOfScheduleResults < ActiveRecord::Migration[5.2]
  def change
    change_column_null :schedule_results, :match_date_time, false
    change_column_null :schedule_results, :section, false
    change_column_null :schedule_results, :opponent, false
    change_column_null :schedule_results, :match_result, false
    change_column_null :schedule_results, :stadium, false
    change_column_null :schedule_results, :home_and_away, false

    change_column_default :schedule_results, :match_result, false
  end
end
