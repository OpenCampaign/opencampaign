class VolunteerRegistrationController < ApplicationController
  before_filter :anon_user_redirect

  PERMITTED_ATTRS = [
    :interests,
    :volunteer_profile,
    :employer,
    :job_title
  ]
  def index
  end

  def show
    @volunteer_registration = VolunteerRegistration.find(params[:id])
  end

  def new
    @volunteer_registration = VolunteerRegistration.new
  end

  def edit
    @volunteer_registration = VolunteerRegistration.find(params[:id])
    if @volunteer_registration.blank?
      assign_errors(@volunteer_registration)
      redirect_to(volunteer_registration_index_path)
    end
  end

  def create
    @volunteer_registration =
      abstracted_new('VolunteerRegistration', PERMITTED_ATTRS,
                     params[:volunteer_registration])
    if @volunteer_registration.valid?
      @volunteer_registration.save
      flash[:success] = "Volunteer Registration Successfully Created"
      redirect_to(volunteer_registration_path(@volunteer_registration.id))
    else
      assign_errors(@volunteer_registration)
      render :new
    end
  end

  def update
    @volunteer_registration = VolunteerRegistration.find(params[:id])
    if abstracted_new('VolunteerRegistration', PERMITTED_ATTRS,
                      params[:volunteer_registration])
      flash[:success] = "Volunteer Registration Successfully Updated."
      redirect_to admin_pages_path
    else
      assign_errors(@volunteer_registration)
      render :edit
    end
  end

  def destroy
    @volunteer_registration = VolunteerRegistration.find(params[:id])
    if @volunteer_registration.destroy!
      flash[:success] = "Successfully Deleted Volunteering Registration"
      redirect_to(volunteer_registration_index_path)
    else
      assign_errors(@volunteer_registration)
      redirect_to(volunteer_registration_index_path)
  end

  private

  def anon_user_redirect
    unless logged_in?
      flash[:info] = "You must first sign up before volunteering"
      redirect_to(register_path)
    end
  end
end
