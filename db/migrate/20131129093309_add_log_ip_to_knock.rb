class AddLogIpToKnock < ActiveRecord::Migration
  def change
    add_column :knocks, :in_ip, :string , :limit =>20
    add_column :knocks, :out_ip, :string , :limit =>20
  end
end
