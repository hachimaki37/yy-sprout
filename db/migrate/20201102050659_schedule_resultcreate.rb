class ScheduleResultcreate < ActiveRecord::Migration[5.2]
  def change
    change_column :schedule_results, :match_date_time, :datetime, default: 0
  end
end
