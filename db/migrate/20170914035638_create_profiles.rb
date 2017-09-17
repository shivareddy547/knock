class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :image
      t.integer :user_id
      t.date :date_of_birth
      t.string :town
      t.string :postal_code
      t.string :country
      t.string :gender
      t.text :about
      t.string :languges_spoken
      t.string :education
      t.string :occupation
      t.string :religion
      t.string :ethnicity

      t.timestamps null: false
    end
  end
end
