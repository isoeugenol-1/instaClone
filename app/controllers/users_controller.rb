class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: [:show, :edit, :update]
  
  def index 
    @user = User.new
  end
  
  def create
   @user = User.new(user_params)
    if @user.save
     redirect_to pictures_path
    else
      render 'index'
    end
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Feed was successfully updated.'
    else
      render 'show'
    end
  end
  
  private
  
  def set_user
    @user = current_user
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
