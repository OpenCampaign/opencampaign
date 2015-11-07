class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
    @basic_auth = BasicAuth.where(email: @user.email).first
    authorize @basic_auth, :edit? if @basic_auth
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    # Update password
    if params[:password] && params[:password_confirmation]
      begin
        basic_auth = BasicAuth.where(email: @user.email).first
        authorize basic_auth, :update?
        basic_auth.password = params[:password]
        basic_auth.password_confirmation = params[:password_confirmation]
        basic_auth.save!
      rescue
        flash.now[:error] = 'Password mismatch, changes not saved.'
      end
    end

    if @user.update_attributes!(user_params) && flash.now[:error].blank?
      flash[:success] = 'Profile updated successfully.'
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(*policy(@user || User).permitted_attributes)
  end

end
