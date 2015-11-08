class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?
  include Pundit
  #after_action :verify_authorized, except: :index
  #after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from OmniAuth::Error, with: :user_not_authenticated

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end
  helper_method :permitted_params

  def assign_errors object, flash_type=:render
    if object.errors.any?
      if flash_type==:redirect
        flash.now[:error] = ""
        object.errors.full_messages.each{ |m| flash.now[:error] << "#{m}<br />" }
      else
        # Default to :render
        flash[:error] = ""
        object.errors.full_messages.each{ |m| flash[:error] << "#{m}<br />" }
      end
    end
  end
  helper_method :assign_errors

  protected

  def current_user
    return @current_user if defined?(@current_user)
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    flash[:notice] = "Successfully logged in." unless current_user.blank?
    session[:user_id] = user.nil? ? user : user.id
  end

  private

  def authenticate
    unless logged_in?
      session[:origin_url] = request.url
      redirect_to login_path
    end
  end

  def user_not_authorized(exception=nil)
    policy_name = exception.policy.class.to_s.underscore
    flash[:error] = I18n.t "pundit.#{policy_name}.#{exception.query}",
      default: 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def user_not_authenticated(exception=nil)
    flash[:error] = I18n.t "authentication.#{exception.query}",
      default: 'You could not be authenticated.'
    redirect_to(request.referrer || root_path)
  end

  def abstracted_new(class_string, permitted_params, params_hash)
    sanitized_hash = {}
    permitted_params.each do |key|
      sanitized_hash[key.to_sym] = params_hash.fetch(key.to_sym)
    end
    class_string.constantize.new( sanitized_hash )
  end

  def abstracted_update(object, permitted_params, params_hash)
    puts "*"*80
    puts object
    puts "*"*80
    puts params_hash
    puts "*"*80
    sanitized_hash = {}
    permitted_params.each do |key|
      sanitized_hash[key.to_sym] = params_hash.fetch(key.to_sym)
    end
    object.update_attributes( sanitized_hash )
  end

  def find_prioritization object
    unless object.prioritization.blank?
      @prioritization = Prioritization.find(object.prioritization.id)
    else
      @prioritization = Prioritization.new
    end
  end

  def update_prioritization object
    find_prioritization object
    unless params[:prioritization].blank?
      @prioritization.banner = params[:prioritization][:banner]
      @prioritization.xml    = params[:prioritization][:xml]
      @prioritization.block  = params[:prioritization][:block]
    end
    object.prioritization = @prioritization
  end
end
