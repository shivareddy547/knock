class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # autocomplete :interest, :name, :full => true

      # GET /users/:id.:format
      def show
        # authorize! :read, @user
      end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end


  def get_interests

    @task = Interest.all
    interests = []
    @task.each do |task|
      interests << {:id => task.id, :title => "#{task.name}" }
    end
    render :text => interests.to_json
  end
  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user

    p 11111111111111
    p user_params

    respond_to do |format|
      if @user.update(user_params)
        # @user.profile.update(user_params[:profile])

        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user

    if request.patch? && params[:user] #&& params[:user][:email]

       @user= User.find(params[:id])
p 111111111111111111111
       p user_params
      if @user.update(user_params)
        p 2222222222222222
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to "/", notice: 'Your profile was successfully updated.'
      else

        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
  def set_user

    @user = User.find(params[:id])

  end

  # def user_params
  #   accessible = [ :email] # extend with your own params
  #   # accessible << [ :name ]
  #   accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
  #   accessible<< [:profile_attributes => [:firstname,:lastname]] unless params[:profile_attributes].blank?
  #   params.require(:user).permit(accessible)
  #   params.require(:user)
  # end
  def user_params
    accessible = [ :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    accessible<< [:profile_attributes => [:firstname,:lastname]] unless params[:profile_attributes].blank?
    params.require(:user).permit(accessible)
  end
end