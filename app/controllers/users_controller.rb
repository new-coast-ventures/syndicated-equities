# ================================================
# RUBY->CONTROLLER->USERSCONTROLLER ==============
# ================================================
class UsersController < ApplicationController
  
  before_action :authenticate_user!

  # investor index
  def index
    @investors = User.all.order(:first_name)
    @investor = User.new
    if params[:search] && !params[:search].blank?
      @investors = User.search(params[:search].capitalize).order("created_at DESC")
    end
    
    
    render 'investors/index'
  end

  def create
    begin
      User.create!(user_params.merge({password: SecureRandom.base64(15)}))
    rescue => e 
      flash[:alert] = "#{e}"
    end
    
    redirect_to users_path
  end

  def update
    begin
      user = User.find(params['id'])
      user.update(user_params)
    rescue => e 
      flash[:alert] = "#{e}"
    end
    
    redirect_to investor_show_path(id: params['id'])
  end

  def investor_show
    @investor = User.find_by(id: params[:id])
    render 'investors/show'
  end

  def show
    @user = User.find_by(id: params[:id])
    
    if @user.admin
      redirect_to users_path and return
    end

    @notes = Note.global
    
    if @user && current_user && @user.id == current_user.id || current_user.admin?
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :approved, :admin)
  end
end