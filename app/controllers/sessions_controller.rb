class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    if @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )
      login!(@user)
      redirect_to user_url(@user)
    else
      fail
      flash[:errors] = "Invalid Username or Password"
      render :new
    end
  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end
end
