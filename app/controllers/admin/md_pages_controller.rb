class Admin::MdPagesController < AdminController
  def index
    @pages = MdPage.all
  end

  def new
    @page = MdPage.new
  end

  def create
    @page = new_with_permit('MdPage', params[:md_page])
    if @page.valid?
      @page.save
      flash[:success] = "Created #{@page.title} page successfully."
      redirect_to admin_pages_path
    else
      assign_errors(@page)
      render :new
    end
  end

  def edit
    @page = MdPage.find(params[:id])
  end

  def update
    @page = MdPage.find(params[:id])
    new_page = new_with_permit('MdPage', params[:md_page])
    if new_page.valid?
      update_with_permit(@page, params[:md_page])
      flash[:success] = "Updated #{@page.title} page successfully."
      redirect_to admin_pages_path
    else
      assign_errors(new_page)
      render :edit
    end
  end

  def show
    @page = MdPage.find(params[:id])
  end

  def destroy
    @page = MdPage.find(params[:id])
    if @page.destroy!
      flash[:success] = "Deleted #{@page.title} successfully."
      redirect_to admin_pages_path
    else
      assign_errors(@page)
      redirect_to admin_pages_path
    end
  end

  private

  def new_with_permit(class_string, params_hash)
    tmp_object = class_string.constantize.new(
      params_hash.permit(current_user.has_role?(:admin))
    )
    tmp_object
  end

  def update_with_permit(object, params_hash)
    tmp_object = object.update_attributes(
      params_hash.permit(current_user.has_role?(:admin))
    )
    tmp_object
  end

  def append_object_errors_to_flash(object)
    object.errors.each do |error, message|
      flash[:error] += "<br />#{error.capitalize} #{message}"
    end
  end
end
