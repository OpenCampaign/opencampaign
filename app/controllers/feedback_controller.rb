class FeedbackController < ApplicationController
  def index
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(
      subject: params[:feedback][:subject],
      first_name: params[:feedback][:first_name],
      last_name: params[:feedback][:last_name],
      phone_number: params[:feedback][:phone_number],
      email: params[:feedback][:email],
      address: params[:feedback][:address],
      comment: params[:feedback][:comment],
    )

    if @feedback.valid?
      @feedback.save
      redirect_to(root_path)
      flash[:info] = "Issue Successfully Created"
    else
      flash[:error] = "An error occurred while creating the position"
      render :new
    end
  end
end
