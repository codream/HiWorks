class CreateKnocks < ActiveRecord::Migration
  def change
    create_table :knocks do |t|
      t.integer  :user_id
      t.datetime :clock_in
      t.datetime :clock_out

      t.timestamps
    end
  end
end
