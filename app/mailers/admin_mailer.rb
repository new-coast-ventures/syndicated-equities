class AdminMailer < ActionMailer::Base
  default from: "se-admin@syndicated-equities.com"

  def new_user_sign_up(user)
    @user = user

    mail(to: ENV['ADMIN_EMAILS'], subject: 'New User Sign Up for Syndicated Equities Investor Portal')
  end

  def user_email_changed(user, old_email)
    @user = user
    @old_email = old_email

    mail(to: ENV['ADMIN_EMAILS'], subject: "Investor #{user.name} updated their email address")
  end
end