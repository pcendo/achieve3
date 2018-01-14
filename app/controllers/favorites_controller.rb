class FavoritesController < ApplicationController
    before_action :authenticate_user, only: [:index]
    
    def create
        favorite = current_user.favorites.create(instagram_id: params[:instagram_id])
        redirect_to instagrams_url, notice: "お気に入りに登録しました"
    end
    
    def destroy
        favorite = current_user.favorites.find_by(instagram_id: params[:instagram_id]).destroy
        redirect_to favorites_url, notice: "お気に入りから削除しました"
    end

    def index
      @favorites_instagrams = current_user.favorite_instagrams
    end
    
    def show
      @instagram = Instagram.find(params[:id])
      @user = User.find(@instagram.user_id)
    end
  
    private
    def instagram_params
      params.require(:instagram).permit(:image, :content, :user_id)
    end
  
    def authenticate_user
      if logged_in?
      else
        redirect_to new_session_path
      end
    end
    
end
