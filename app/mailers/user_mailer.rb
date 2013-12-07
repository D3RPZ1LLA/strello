class UserMailer < ActionMailer::Base
  default from: "sterling.kxz@gmail.com"
  
  def welcome_email(user)
    @user = user
    mail(to: "sterling.kxz@gmail.com", subject: 'Welcome to Strello')
  end
  
  def forgot_password(user)
    # ...
  end
end
