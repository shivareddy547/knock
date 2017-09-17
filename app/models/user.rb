class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  # attr_accessible :email, :name
  # has_one :profile

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  has_many :events,dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_and_belongs_to_many :interests
  # has_and_belongs_to_many :interests, :class_name => "Interest", :join_table => "interests_users", :association_foreign_key => "user_id"
  # accepts_nested_attributes_for :profile_attributes
  has_one :profile,:foreign_key => "user_id", :class_name => "Profile", dependent: :destroy
  # attr_accessor :profile
  has_many :user_groups
  has_many :groups, through: :user_groups

  # accepts_nested_attributes_for :profile, update_only: true, allow_destroy: true
  # accepts_nested_attributes_for :profile,
  #                               :update_only => true

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            name: auth.extra.raw_info.name,
            #username: auth.info.nickname || auth.uid,
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def profile_build(resource,user_params)
    profile = resource.build_profile

    profile.firstname = user_params[:profile_attributes][:firstname]
    profile.lastname = user_params[:profile_attributes][:lastname]
    profile.image = user_params[:profile_attributes][:image]
    profile.date_of_birth = user_params[:profile_attributes][:date_of_birth]
    profile.town = user_params[:profile_attributes][:town]
    profile.postal_code = user_params[:profile_attributes][:postal_code]
    profile.country = user_params[:profile_attributes][:country]
    profile.gender = user_params[:profile_attributes][:gender]
    profile.about = user_params[:profile_attributes][:about]
    profile.languges_spoken = user_params[:profile_attributes][:languges_spoken]
    profile.education = user_params[:profile_attributes][:education]
    profile.occupation = user_params[:profile_attributes][:occupation]
    profile.religion = user_params[:profile_attributes][:religion]
    profile.ethnicity = user_params[:profile_attributes][:ethnicity]
    profile.save
    if user_params[:interests].present?
      user_params[:interests].reject(&:empty?).each do |each_rec|
        p "=====each ======"
        p each_rec
        p i= Interest.find(each_rec.to_i)
        p 2222222222

       # p  interest = Interest.find(each_rec.to_i)
      p  resource.interests << i
        # interest = resource.interests.build(:id=>each_rec)
        # resource.save
      end
    end

  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end