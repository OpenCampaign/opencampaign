class SocialController < ApplicationController
  def index
    @streams = Social.all
  end
end
