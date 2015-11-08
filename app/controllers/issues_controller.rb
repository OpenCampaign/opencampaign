class IssuesController < ApplicationController
  def index
    @issues = Issue.all.order(title: :asc)
  end
end
