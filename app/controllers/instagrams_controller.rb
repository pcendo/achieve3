class InstagramsController < ApplicationController
    before_action :set_instagram, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:new, :edit, :show, :index]
    before_action :ensure_correct_user, only: [:edit,:update,:destroy]
    
    def index
        @instagrams = Instagram.all
    end
    
    def new
      if params[:back]
        @instagram = Instagram.new(instagram_params)
      else
        @instagram = Instagram.new
      end
    end
    
    def create
      @instagram = Instagram.new(instagram_params)
      @instagram.user_id = current_user.id
      @instagram.image.retrieve_from_cache! params[:cache][:image]

      if @instagram.save
        redirect_to instagrams_path, notice: "PHOTOをアップしました‼"
      else
        render 'new'
      end
    end
    
    def confirm
        @instagram = Instagram.new(instagram_params)
        render :new if @instagram.invalid?
    end
    
    def show
      @instagram = Instagram.find(params[:id])
      @user = User.find(@instagram.user_id)
      @favorite = current_user.favorites.find_by(instagram_id: @instagram.id)
    end
    
    def edit
    end
    
    def update
      if @instagram.update(instagram_params)
        redirect_to instagrams_path, notice: "PHOTOを編集しました‼"
      else
        render 'edit'
      end
    end
    
    def destroy
      @instagram.destroy
      redirect_to instagrams_path, notice: "PHOTOを削除しました‼"
    end
    
    private
    def instagram_params
        params.require(:instagram).permit(:content, :image, :user_id)
    end
    
    def set_instagram
        @instagram = Instagram.find(params[:id])
    end
    
    def authenticate_user
      if logged_in?
      else
        redirect_to new_session_path
      end
    end

    def ensure_correct_user
      @instagram = Instagram.find_by(id: params[:id])
      @current_user = User.find(current_user.id)
      if @current_user.id != @instagram.user_id
        flash[:notice] = "編集の権限がありません"
        redirect_to instagrams_path
      end
    end
end
