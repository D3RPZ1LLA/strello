class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    if @user = User.find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "User not found"
      redirect_to new_user_url
    end
  end
end
