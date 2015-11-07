class Notifier < ActionMailer::Base
  default from: ENV['SMTP_FROM_ADDRESS']

  def welcome(basic_auth)
    @basic_auth = basic_auth
    mail(to: @basic_auth.email, subject: "Welcome to #{ENV['SITE_TITLE']}") do |format|
      format.text
      format.html
    end
  end

  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: "#{ENV['SITE_TITLE']} Password Reset Request") do |format|
      format.text
      format.html
    end
  end

  def password_changed(user)
    @user = user
    mail(to: @user.email, subject: "#{ENV['SITE_TITLE']} Password Changed") do |format|
      format.text
      format.html
    end
  end
end
