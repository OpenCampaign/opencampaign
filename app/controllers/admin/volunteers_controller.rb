class Admin::VolunteersController < AdminController
  def index
    @volunteers = VolunteerRegistration.all
  end
end
