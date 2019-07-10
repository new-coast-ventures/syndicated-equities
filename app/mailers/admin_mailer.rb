class AdminMailer < ActionMailer::Base
  default from: "se-admin@syndicated-equities.com"

  def new_user_sign_up(user)
    @user = user

    mail(to: ENV['ADMIN_EMAILS'], subject: 'New User Sign Up for Syndicated Equities Investor Portal')
  end
end