class Admin::IssuesController < AdminController
  PERMITTED_ATTRS = [:title, :position]

  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = abstracted_new('Issue', PERMITTED_ATTRS, params[:issue])
    if @issue.valid?
      @issue.save
      flash[:info] = "Created '#{@issue.title}' issue successfully."
      redirect_to admin_issues_path
    else
      assign_errors(@issue)
      render :new
    end
  end

  def edit
    @issue = Issue.find(params[:id])
    if @issue.blank?
      flash[:error] = "Issue not found"
      redirect_to admin_issues_path
    end
  end

  def update
    @issue = Issue.find(params[:id])
    if abstracted_update(@issue, PERMITTED_ATTRS, params[:issue])
      flash[:info] = "Updated '#{@issue.title}' issue successfully."
      redirect_to admin_issues_path
    else
      assign_errors(@issue)
      render :edit
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    if @issue && @issue.destroy!
      flash[:info] = "Issue Successfully removed"
      redirect_to admin_issues_path
    else
      assign_errors(@issue)
      redirect_to admin_issues_path
    end
  end
end
