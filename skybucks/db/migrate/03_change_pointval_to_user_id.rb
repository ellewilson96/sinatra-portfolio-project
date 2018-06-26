class ChangePointvalToUserId < ActiveRecord::Migration
  def change
    change_column :flights, :point_value, :user_id
  end
end
