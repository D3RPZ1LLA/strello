class UsersController < ApplicationController
  # before_filter :personal_clearance, only: [:edit, :update, :destroy]
  before_filter :logged_in_clearance, only: :home

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login!(@user)
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    if @user = User.includes(:member_boards, :cards).find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "User not found"
      redirect_to new_user_url
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if request.xhr?
      render json: @user
    else
      redirect_to boards_url
    end
  end

  def destroy
  end

  def home
    render :home
  end
end
