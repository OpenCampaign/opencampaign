class Admin::VolunteersController < AdminController
  def index
    @volunteers = VolunteerRegistration.all
  end

  def show
    @volunteers = VolunteerRegistration.find(params[:id])
  end
end
