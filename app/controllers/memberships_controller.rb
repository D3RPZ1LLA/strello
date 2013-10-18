class MembershipsController < ApplicationController
  def new
    render :new if @board = Board.find(params[:board_id])
  end

  def create
    @board = Board.find(params[:board_id])
    if @user = User.find_by_email(params[:member][:email])
      @membership = Membership.new(
        user_id: @user.id,
        board_id: @board.id,
        admin: false
      )
      if request.xhr?
        if @membership.save
          p  @user.avatar.url(:thumb)
          render json: { 
            avatar_file_name: @user.avatar_file_name,
            avatar_url: @user.avatar.url(:thumb) 
          }
        else 
          head status: 422
        end
      else
        if @member.save
          redirect_to board_url(@board)
        else
          flash[:errors] = @membership.errors.full_messages
          render :new
        end
      end
    else
      flash[:errors] = "User not found"
      render :new
    end
  end
end
