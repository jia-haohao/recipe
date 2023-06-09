class CookMailer < ApplicationMailer
  def cook_mail(cook) 
    @cook = cook
    @title = cook.title
    mail(to: cook.user.email, subject: "このレシピは削除されました")
  end
end
