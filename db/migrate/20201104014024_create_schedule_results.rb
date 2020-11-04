class CreateScheduleResults < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_results do |t|
      t.datetime :match_date_time
      t.integer :section, null: false
      t.integer :opponent, null: false
      t.integer :match_result, default: ""
      t.integer :stadium, null: false
      t.integer :home_and_away, null: false

      t.timestamps
    end
  end
end
