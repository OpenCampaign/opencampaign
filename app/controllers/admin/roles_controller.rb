class Admin::RolesController < AdminController

  def index
    @users = User.all
    @roles = Role.all
  end

  def create
    unless params["users"].blank? # no users have roles, ignore this post
      update_response   = false unless params[:confirm] == "Update Roles"
      update_response ||= Role.update_user_roles params[:users]
      if update_response == true
        flash[:success] = "Roles updated successfully."
      else
        flash[:error]   = "Unable to update roles."
      end
    else
      flash[:error] = "At least one user must be assigned a role."
    end
    redirect_to admin_roles_path
  end
end
