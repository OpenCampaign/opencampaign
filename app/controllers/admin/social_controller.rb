class Admin::SocialController < AdminController
  PERMITTED_ATTRS = [:name, :payload]

  def index
    @socials = Social.all
  end
  def new
    @social = Social.new
  end
  def edit
    @social = Social.find(params[:id])
    @social.payload = @social.payload.to_json
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
  def update
    @social = Social.find(params[:id])
    puts "+"*80
    puts params[:social].inspect
    puts "+"*80
    puts @social.inspect
    puts "+"*80
    params[:social][:payload] = params[:social][:payload].to_json
    if abstracted_update(@social, PERMITTED_ATTRS, params[:social])
      flash[:success] = "Updated #{@social.name} Social Integration successfully."
      redirect_to(admin_social_index_path)
    else
      assign_errors(@social)
      render :edit
    end
  end
end
