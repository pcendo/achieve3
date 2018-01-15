class InstagramMailer < ApplicationMailer
    
    def instagram_mail(instagram)
        @instagram = instagram
        @user = User.find(instagram.user_id)
        @email = ["endo9634@gmail.com", @user.email]
        mail to: @email, subject: "PHOTO登録の確認メール"
    end
    
end
