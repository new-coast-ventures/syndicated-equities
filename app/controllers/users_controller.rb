# ================================================
# RUBY->CONTROLLER->USERSCONTROLLER ==============
# ================================================
class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :check_master_admin

  # investor index
  def index
    @investors = User.all.order(:first_name)
    # @investors = User.where(email: 'rob@newcoastventures.com')
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
    @investment = Investment.new

    render 'investors/show'
  end

  def show
    @order = params['order'] ? params['order'] : 'DESC'
   
    @user = User.find_by(id: params[:id])

    if params['investor_view']
      current_user.update(investor_view: ActiveModel::Type::Boolean.new.cast(params['investor_view']))
      @user = current_user
    end

    user_investments = Investment.combine_investments(@user.id, @order)
    @investments = user_investments[:investments]
    @property_ids = user_investments[:property_ids]
    
    @investment = Investment.new
    
    if (@user.admin || @user.employee) && !@user.investor_view
      redirect_to users_path and return
    end
    
    @notes = Note.global
    
    if @user && current_user && @user.id == current_user.id
      @view = "dashboard"
      render 'show'
    else
      flash[:alert] = 'Not authorized'
      redirect_to main_app.root_path
    end
  end

  def dashboard
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :address_1, :address_2, :city, :state, :country, :zip_code, :email, :approved, :admin, :employee)
  end
end