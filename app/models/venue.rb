class Venue < ActiveRecord::Base

  has_one :location
  accepts_nested_attributes_for :location
  mount_uploader :image, ImageUploader

end
