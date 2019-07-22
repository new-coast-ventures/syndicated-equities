# ================================================
# RUBY->CONTROLLER->USERSCONTROLLER ==============
# ================================================
class UsersController < ApplicationController
  
  before_action :authenticate_user!

  # investor index
  def index
    @investors = User.all
    @investor = User.new
    if params[:search] && !params[:search].blank?
      @investors = User.search(params[:search].capitalize).order("created_at DESC")
    end
    
    
    render 'investors/index'
  end

  def show
    @user = User.find_by(id: params[:id])
    
    if @user.admin
      redirect_to properties_path and return
    end

    @notes = Note.global
    
    if @user && current_user && @user.id == current_user.id || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end
end