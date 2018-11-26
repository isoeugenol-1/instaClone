class PicturesController < ApplicationController
  before_action :set_picture, only: [:edit, :update, :destroy, :show]
  before_action :login_check, only: [:show, :edit, :new, :destroy, :update]
  before_action :current_check, only: [:destroy, :edit, :update]
  include ApplicationHelper
  
  def index
    @picture = Picture.all
  end
  
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      #ContactMailer.contact_mail(current_user,@picture).deliver
      redirect_to pictures_path, notice: "ブログを作成しました！"
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end
  
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"ブログを削除しました！"
  end
  
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def confirm
    @picture = Picture.new(picture_params)
    if @picture.title =="" || @picture.content ==""
      flash[:error] =  "内容を入力してください"
      redirect_to new_picture_path
    end
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:title, :content, :@curuser, :image, :image_cache)
  end
  
  def set_picture
    @picture = Picture.find(params[:id])
  end
  
  def login_check
    unless logged_in?
      flash[:error] =  "ログインしてください"
      redirect_to new_session_path
    end
  end
  
  def current_check
    if @picture.user_id != current_user.id
      flash[:error] =  "current error"
      redirect_to pictures_path
    end
  end
end
