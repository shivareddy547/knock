class Profile < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user

  accepts_nested_attributes_for :user
end
