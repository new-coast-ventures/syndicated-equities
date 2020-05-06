class AdminMailer < ActionMailer::Base
  default from: "se-admin@syndicated-equities.com"

  def new_user_sign_up(user)
    @user = user
    subject = if Rails.env.staging? || Rails.env.development?
                "[STAGING] New User Sign Up for Syndicated Equities Investor Portal"
              else
                "New User Sign Up for Syndicated Equities Investor Portal"
              end
    mail(to: ENV['ADMIN_EMAILS'], subject: subject)
  end

  def user_email_changed(user, old_email)
    @user = user
    @old_email = old_email

    mail(to: ENV['ADMIN_EMAILS'], subject: "Investor #{user.name} updated their email address")
  end

  def user_fields_changed(user, old_user)
    @user = user

    mail(to: ENV['ADMIN_EMAILS'], subject: "Investor #{user.name} updated their details")
  end
end