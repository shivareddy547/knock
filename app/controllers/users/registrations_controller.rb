class Users::RegistrationsController < Devise::RegistrationsController
  # before_filter :user_params
  # autocomplete :interest, :name, :full => true
  def update
    super

    if resource.save
      resource.profile_build(resource,user_params)

    end
  end



  #
  def user_params
    accessible = [ :name, :email,:password, :password_confirmation,:current_password,:interests=>[],
    :profile_attributes=>[:firstname,:lastname,:image,:date_of_birth,:town,:postal_code,:country,:gender,:about,:languges_spoken,
                          :education,:occupation,:religion,:ethnicity] ] # extend with your own params

    params.require(:user).permit(accessible)

  end



end