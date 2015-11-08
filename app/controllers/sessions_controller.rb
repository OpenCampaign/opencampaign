class SessionsController < ApplicationController
  skip_before_filter :authenticate, only: [:new, :create, :destroy, :failure]
  before_filter :setup, only: [:create]
  # Include authetication module from lib/authentication/<module>.rb
  include Authentication.const_get(ENV["AUTHENTICATION_MODULE"].classify)

  def new
  end

  def create
    self.current_user = find_or_create_by_uid(env['uid'])
    if current_user.blank?
      redirect_to(action: failure, message: "You could not be authenticated.") and return
    else
      current_user.add_role('admin') if ENV["DEMO_MODE"] && params[:is_admin]
      redirect_path = session[:origin_url].blank? ? root_path : session[:origin_url]
      redirect_to(redirect_path) and return
    end
  end

  def destroy
    current_user = nil
    session[:user_id] = nil
    session[:origin_url] = nil
    flash[:notice] = "You have successfully signed out."
    redirect_to root_path
  end

  def failure
    flash.now[:error]    = "You could not be authenticated. "
    flash.now[:error]   += "Please verify your credentials."
    unless params[:message] == 'invalid_credentials'
      flash.now[:message]  = params[:message] unless params[:message].blank?
    end
    render template: 'sessions/new', status: 500 and return
  end

  private

  def setup
    env['uid'] = uid
    redirect_to(action: failure) and return if env['uid'].blank?
  end
end
