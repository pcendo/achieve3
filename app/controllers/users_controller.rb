class UsersController < ApplicationController
    before_action :authenticate_user, only: [:edit ]

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            UserMailer.user_mail(@user).deliver
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def edit
    end
    
    private
    def user_params
        params.require(:user).permit(:email, :name, :cname, :password,
                                     :password_confirmation, :image )
    end
    
    def authenticate_user
      if logged_in?
      else
        redirect_to new_session_path
      end
    end
    
end
