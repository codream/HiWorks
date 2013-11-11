class CreateKnocks < ActiveRecord::Migration
  def change
    create_table :knocks do |t|
      t.integer  :user_id
      t.datetime :clock_in
      t.datetime :clock_out
      t.string   :description
      t.integer  :limit => 1
      #t.integer  :day, :limit => 1

      t.timestamps
    end
  end
end
