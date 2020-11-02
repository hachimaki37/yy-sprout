class ChangeDatatypeOpponentsOfScheduleResults < ActiveRecord::Migration[5.2]
  def change_column
    change_column :schedule_results, :opponent, 'integer USING CAST(opponent AS integer)'
  end
end
