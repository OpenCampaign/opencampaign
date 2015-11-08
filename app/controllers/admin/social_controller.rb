class Admin::SocialController < AdminController

  def index
    @socials = Social.all
  end
  def new
    @social = Social.new
  end
  def edit
    @social = Social.find(params[:id])
    if @social.blank?
      flash[:error] = "Social Integration not found"
      redirect_to(admin_social_path)
    end
  end
  def destroy
    @social = Social.find(params[:id])
    unless @social.blank?
      @social.delete
      flash[:info] = "Issue Successfully removed"
      redirect_to(admin_social_index_path)
    else
      assign_errors(@social)
      redirect_to(admin_social_index_path)
    end
  end
end
