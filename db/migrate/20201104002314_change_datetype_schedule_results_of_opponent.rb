class ChangeDatetypeScheduleResultsOfOpponent < ActiveRecord::Migration[5.2]
  def change
    change_column :schedule_results, :opponent, :integer, using: "opponent::integer", null: false
  end
end
