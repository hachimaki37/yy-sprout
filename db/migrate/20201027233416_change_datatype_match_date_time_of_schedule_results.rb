class ChangeDatatypeMatchDateTimeOfScheduleResults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :schedule_results, :match_date_time, false
  end
end
