class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :latitude
      t.string :longitude
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.integer :venue_id

      t.timestamps null: false
    end
  end
end
