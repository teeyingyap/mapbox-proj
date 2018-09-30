class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
