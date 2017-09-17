class Event < ActiveRecord::Base

  has_many :notifications, dependent: :destroy
  has_many :event_members
  has_many :users,:through => :event_members
  has_many :groups,:through => :event_members
  belongs_to :user

  def update_users_groups(params)
    users=[]
    groups =[]
     params.reject(&:empty?).each do |user_or_group|
      if user_or_group.include?("User")
       users << user_or_group.split(":").first
      else
           groups << user_or_group.split(":").first
      end
    end
    self.users=User.where(:id=>users)
    self.groups=Group.where(:id=>groups)

  end


end
