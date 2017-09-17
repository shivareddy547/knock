class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :image
      t.string :cover_image
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
