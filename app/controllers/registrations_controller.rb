# ================================================
# RUBY->CONTROLLER->REGISTRATIONSCONTROLLER ======
# ================================================
class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  def new
    build_resource({})
    resource.address = Address.new
    respond_with resource
  end

  def edit
    resource.build_address if resource.address.nil?
  end

  def create
    super do
      resource.investments = Investment.where({investor_email: resource.email})
      resource.approved = false
      resource.save
    end
  end

  private

  def sign_up_params
    address_params = [:id, :line1, :line2, :city, :state, :zip]

    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, [address_attributes: address_params])
  end

  def account_update_params
    address_params = [:id, :line1, :line2, :city, :state, :zip]

    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, [address_attributes: address_params])
  end

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end
  end
end
