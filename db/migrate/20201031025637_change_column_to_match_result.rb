class ChangeColumnToMatchResult < ActiveRecord::Migration[5.2]
  def up
    change_column :schedule_results, :match_result,:integer, null: true
  end

  def dpwn
    change_column :schedule_results, :match_result,:integer, null: false
  end
end
