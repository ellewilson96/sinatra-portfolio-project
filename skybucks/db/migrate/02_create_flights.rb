class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :origin
      t.string :destination
      t.integer :point_value
  end
end
end
