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

      UserMailer.welcome_email(@user).deliver!

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
    @current_user.update_attributes(strong_user_params)
    
    update_password if params[:user].include?(:password)
    update_email if params[:user].include?(:email)
    
    if request.xhr?
      render json: @current_user
    else
      redirect_to edit_user_url(@current_user)
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
    if @current_user.has_password? (params[:user][:password])

      if params[:user][:new_password] == params[:user][:new_password_again]

        if User.is_valid_password? (params[:user][:new_password])
         
          puts "changing pw"
          @current_user.change_password (params[:user][:new_password])
          
        else
          flash[:errors] = "Password must be 6-20 characters"
        end
        
      else
        flash[:errors] = "Passwords do not match."
      end

    else
      flash[:errors] = "Invalid password."
    end
  end
  
  def update_email
  end
end
