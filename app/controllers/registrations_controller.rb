# ================================================
# RUBY->CONTROLLER->REGISTRATIONSCONTROLLER ======
# ================================================
class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    self.resource.address = Address.new
    respond_with self.resource
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
end
