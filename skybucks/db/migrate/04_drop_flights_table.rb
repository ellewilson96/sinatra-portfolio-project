class DropFlightsTable < ActiveRecord::Migration
  def change
    drop_table :flights
  end
end
