class Admin::FeedbackController < AdminController
  def index
    @feedbacks = Feedback.all
  end

  def show
    @feedback = Feedback.find(params[:id])
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    unless @feedback.blank?
      @feedback.delete
      flash[:info] = "Issue Successfully removed"
      redirect_to(admin_feedbacks_path)
    else
      flash[:error] = "An error occurred while removing the feedback"
      redirect_to(admin_feedbacks_path)
    end
  end
end
