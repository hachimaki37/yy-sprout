class CreateScheduleResults < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_results do |t|
      t.datetime :match_date_time
      t.integer :section
      t.string :opponent
      t.string :match_result
      t.string :stadium
      t.string :home_and_away

      t.timestamps
    end
  end
end
