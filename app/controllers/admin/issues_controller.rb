class Admin::IssuesController < AdminController
  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = Issue.new
  end

  def edit
    @issue = Issue.find(params[:id])
    if @issue.blank?
      flash[:error] = "Issue not found"
      redirect_to(admin_issues_path)
    end
  end

  def create
    @issue = Issue.new(title: params[:issue][:title], opinion: params[:issue][:position])
    if @issue.valid?
      @issue.save
      redirect_to(admin_issues_path)
      flash[:info] = "Issue Successfully Created"
    else
      flash[:error] = "An error occurred while creating the position"
      render :new
    end
  end

  def update
    @issue = Issue.find(params[:id])
    if Issue.new(title: params[:issue][:title],
      opinion: params[:issue][:position]).valid?
      @issue.update_attributes(title: params[:issue][:title],
        opinion: params[:issue][:position])
      flash[:info] = "Issue Successfully Updated"
      redirect_to(admin_issues_path)
    else
      flash[:error] = "Invalid entries were submitted!"
      render :edit
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    unless @issue.blank?
      @issue.delete
      flash[:info] = "Issue Successfully removed"
      redirect_to(admin_issues_path)
    else
      flash[:error] = "An error occurred while removing the issue"
      redirect_to(admin_issues_path)
    end
  end
end
