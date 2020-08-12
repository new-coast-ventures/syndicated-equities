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

  def distribution_import_complete(invalid_entries, property_name)
    puts "----------- Sending Distribution Complete Email -------------"
    if !invalid_entries[:invalid_entities].blank? || !invalid_entries[:invalid_emails].blank?
      @notice = ""
      
      if !invalid_entries[:invalid_entities].blank?
        @notice += "These Entities failed to load: <br> #{invalid_entries[:invalid_entities].join("<br>")}"
      end
      
      if !invalid_entries[:invalid_emails].blank?
        @notice += "<br> Emails #{invalid_entries[:invalid_emails].join("<br>")} do not belong to any investment"
      end
      
    else
     @notice = 'Distributions have been uploaded with no errors.'
    end
    @property_name = property_name
    mail(to: ENV['ADMIN_EMAILS'], subject: "Distribution Import For #{property_name} Complete")
  rescue => e  
    put " Error sending Distribution Complete email: #{e}"
  end

  def distribution_import_error(error, property_name)
    @error = error

    mail(to: ENV['ADMIN_EMAILS'], subject: "Distribution Import For #{property_name} Failed")
  end

  def open_property_request(amount, entity, user, property)
    @amount = amount
    @entity = entity
    @user = user
    @property = property

    mail(to: ENV['ADMIN_EMAILS'], subject: "Open Property Inquiry")
  end
end