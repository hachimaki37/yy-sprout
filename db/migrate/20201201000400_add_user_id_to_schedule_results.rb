class AddUserIdToScheduleResults < ActiveRecord::Migration[5.2]
  def change
    add_column :schedule_results, :user_id, :integer
  end
end
