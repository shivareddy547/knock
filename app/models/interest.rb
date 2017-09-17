class Interest < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  mount_uploader :cover_image, ImageUploader
  has_and_belongs_to_many :users
  # has_and_belongs_to_many :users, :class_name => "User", :join_table => "interests_users", :association_foreign_key => "interest_id"


end
