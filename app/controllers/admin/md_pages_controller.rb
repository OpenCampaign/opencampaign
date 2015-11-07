class Admin::MdPagesController < AdminController
  def index
    @pages = MdPage.all
  end

  def create
    @page = MdPage.new(title: params[:md_page][:title], content: params[:md_page][:content])
    if @page.save
      flash[:success] = "Created #{@page.title} page successfully."
      redirect_to admin_md_pages_path
    else
      flash[:error]   = 'Unable to create page.'
      render(:edit, @page)
    end
  end
end
