class UsersController < ApplicationController
  before_filter :personal_clearance, only: [:edit, :update, :destroy]
  before_filter :logged_in_clearance, only: [:home, :edit]

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
  
  def edit
    @user = User.find_by_id(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
  
    @user.update_attributes(strong_user_params)
    
    update_password if params[:user].include?(:password)
    update_email if params[:user].include?(:email)
    
    if request.xhr?
      render json: @user
    else
      redirect_to root_url
    end
  end

  def destroy
  end

  def home
    render :home
  end
  
  private
  def strong_user_params
    params[:user].select do |k,v|
      ["username", "avatar", "full_name", "initials", "bio"].include?(k)
    end
  end
  
  def update_password
  end
  
  def update_email
  end
end
