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
    if current_user.id == @user.id
      render 'show'
    else
      render plain: 'Not Authorized', status: 500
    end
  end

  # ----------------------------------------------
  # EDIT -----------------------------------------
  # ----------------------------------------------

  def edit
    @user = User.find(params[:id])
  end

  # ----------------------------------------------
  # UPDATE ---------------------------------------
  # ----------------------------------------------

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(form_params)
      redirect_to :back, notice: 'Changes saved'
    else
      redirect_to :back, alert: "There was an issue saving your changes. #{@user.errors.full_messages.to_sentence}"
    end
  end

  # ----------------------------------------------
  # PRIVATE --------------------------------------
  # ----------------------------------------------

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
