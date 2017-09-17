class CreateEventMembers < ActiveRecord::Migration
  def change
    create_table :event_members do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :group_id
      t.string :type

      t.timestamps null: false
    end
  end
end
