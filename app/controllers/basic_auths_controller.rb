class BasicAuthsController < ApplicationController
  skip_before_filter :authenticate, only: [:new, :verify, :forgot, :reset]

  def new
  end

  #TODO: Refactor verify email action to fit RESTful actions sometime
  def verify
    logout_user
    basic_auth = get_auth_by_token(params[:basic_auth_id], params[:token])
    user = get_user_by_basic_auth(basic_auth)

    basic_auth.verified = true
    basic_auth.token = nil
    if basic_auth.save
      basic_auth.identity.update_attribute(:updated_at, Time.now)
      user.add_role ENV['VERIFIED_USER_ROLE'].to_sym
      flash[:success] = "Email verified successfully. Please log in."
      redirect_to login_path
    else
      flash[:error] = "Email could not be verified."
      redirect_to login_path
    end
  end

  #TODO: Refactor password reset trigger to fit RESTful actions sometime
  def forgot
    logout_user

    unless params[:email]
      render 'forgot_password'
    else
      basic_auth = BasicAuth.where(email: params[:email]).first
      user = get_user_by_basic_auth(basic_auth)
      raise Pundit::NotAuthorizedError, "Invalid password reset request." unless user

      Notifier.reset_password(user).deliver
      flash[:success] = "Password reset link sent."
      redirect_to login_path
    end
  end

  #TODO: Refactor reset password action to fit RESTful actions sometime
  def reset
    logout_user
    basic_auth = get_auth_by_token(params[:basic_auth_id], params[:token])
    user = get_user_by_basic_auth(basic_auth)

    unless params[:password] && params[:password_confirmation]
      # Valid token & id - show password reset form
      render 'password_reset', locals: { basic_auth_id: params[:basic_auth_id], token: params[:token] }
    else
      raise Pundit::NotAuthorizedError, "Password cannot be reset on unverified accounts." unless basic_auth.verified? == true

      # Valid token, id, and password fields on a verified account - reset password
      basic_auth.password = params[:password]
      basic_auth.password_confirmation = params[:password_confirmation]
      basic_auth.token = nil
      if basic_auth.save
        basic_auth.identity.update_attribute(:updated_at, Time.now)
        Notifier.password_changed(user).deliver
        flash[:success] = "Password changed successfully."
        redirect_to login_path
      else
        flash[:error] = "Password could not be changed."
        redirect_to login_path
      end
    end
  end

  private

  def get_auth_by_token(basic_auth_id, token)
    basic_auth = BasicAuth.where(id: basic_auth_id, token: token).first
    raise Pundit::NotAuthorizedError, "Invalid token & email combination." unless basic_auth
    basic_auth
  end

  def get_user_by_basic_auth(basic_auth)
    user = basic_auth.identity.user unless basic_auth.blank?
    raise Pundit::NotAuthorizedError, "No user matches authentication credentials." unless user
    user
  end

  def logout_user
    current_user = nil
    session[:user_id] = nil
  end
end
