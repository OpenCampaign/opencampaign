class Admin::MdPagesController < AdminController
  PERMITTED_ATTRS = [:title, :content, :slug]

  def index
    @pages = MdPage.all
  end

  def new
    @page = MdPage.new
  end

  def create
    @page = abstracted_new('MdPage', PERMITTED_ATTRS, params[:md_page])
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
    new_page = abstracted_new('MdPage', PERMITTED_ATTRS, params[:md_page])
    if new_page.valid?
      abstracted_update(@page, PERMITTED_ATTRS, params[:md_page])
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
end
