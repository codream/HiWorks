class AddLogDateToKnock < ActiveRecord::Migration
  def change
    add_column :knocks, :log_date, :date
    add_index :knocks, :log_date
    add_index :knocks, :user_id
  end
end
