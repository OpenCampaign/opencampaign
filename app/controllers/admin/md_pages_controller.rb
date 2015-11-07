class Admin::MdPagesController < AdminController
  def index
    @pages = MdPage.all
  end

  def new
    @page = MdPage.new
  end

  def create
    page = params[:md_page]
    @page = MdPage.new(title: page[:title], content: page[:content])
    if @page.valid?
      @page.save
      flash[:success] = "Created #{@page.title} page successfully."
      redirect_to admin_pages_path
    else
      flash[:error]  = 'Unable to create the page due to the following errors:'
      @page.errors.each do |error, message|
        flash[:error] += "<br />#{error.capitalize} #{message}"
      end
      render :edit
    end
  end

  def edit
    @page = MdPage.find(params[:id])
  end

  def update
    page = params[:md_page]
    @page = MdPage.new(title: page[:title], content: page[:content])
    if @page.valid?
      @page.save
      flash[:success] = "Created #{@page.title} page successfully."
      redirect_to admin_pages_path
    else
      flash[:error]  = 'Unable to update the page due to the following errors:'
      @page.errors.each do |error, message|
        flash[:error] += "<br />#{error.capitalize} #{message}"
      end
      render :edit
    end
  end


  def show
    @page = MdPage.find(params[:id])
  end
end
