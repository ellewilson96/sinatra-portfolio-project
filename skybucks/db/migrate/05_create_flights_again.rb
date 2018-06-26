class CreateFlightsAgain < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :origin
      t.string :destination
      t.integer :user_id
  end
end
end
