class ChangeColumnToScheduleResults < ActiveRecord::Migration[5.2]
  def up
    change_column :schedule_results, :match_date_time,:datetime, null: true, default: 0
  end

  def dpwn
    change_column :schedule_results, :match_date_time,:datetime, null: false
  end
end
