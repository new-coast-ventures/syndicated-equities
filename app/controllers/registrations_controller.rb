class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    self.resource.address = Address.new
    respond_with self.resource
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, [address_attributes: [:id, :line1, :line2, :city, :state, :zip]])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, [address_attributes: [:id, :line1, :line2, :city, :state, :zip]])
  end
end
