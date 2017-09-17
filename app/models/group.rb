class Group < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :user_groups
  has_many :users, through: :user_groups
  accepts_nested_attributes_for :users

  def build_user_groups(params)
p 1111111111111111111111111111
 p  users = User.where(:id=>params[:user_ids])
  p  self.users << users

  end

end
