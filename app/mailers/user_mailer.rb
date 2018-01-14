class UserMailer < ApplicationMailer
    
    def user_mail(user)
        @user = user
        @email = ["endo9634@gmail.com", @user.email]
        mail to: @email, subject: "ユーザ登録の確認メール"
    end

end
