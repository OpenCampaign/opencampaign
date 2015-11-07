class Admin::IssueController < AdminController
  def index
    @issue = Issue.all
  end

  def create
    @issue = Issue.new(title: params[:title], position: params[:position])
  end

  def update
    @issue = Issue.find(params[:id])
    unless @issue.blank?
      @issue.update_attributes(title: params[:title], position: params[:position])
    else
      redirect_to(action: index, message: "Issue does not exist!") and return
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.delete unless @issue.blank?
  rescue redirect_to(action: index, message: "An error occurred while removing the issue") and return
  end
end
