# ================================================
# RUBY->CONTROLLER->USERSCONTROLLER ==============
# ================================================
class UsersController < ApplicationController
  before_filter :authenticate_user!
  # ----------------------------------------------
  # SHOW -----------------------------------------
  # ----------------------------------------------

  def show
    @user = User.find(params[:id])
    if current_user.id == @user.id || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
