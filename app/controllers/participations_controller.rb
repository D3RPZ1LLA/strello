class ParticipationsController < ApplicationController
  def new
    @card = Card.includes(catagory: [board: :members]).find(params[:card_id])
    render :new
  end

  def create
    @participation = Participation.new(params[:participation])
    @user = User.find(params[:participation][:user_id])
    @participation.card_id = params[:card_id]
    if @participation.save
      if request.xhr?
        render json: {
          user: @user,
          avatar_url: @user.avatar.url(:thumb) 
        }
      else
        redirect_to edit_card_url(params[:card_id])
      end
    else
      if request.xhr?
        head status: 422
      else
        render :new
      end
    end
  end

  def destroy
    if @participation = Participation.find_by_id(params[:id])
      @participation.destroy
    else
      flash[:errors] = "404"
    end
    redirect_to user_url(current_user)
  end
end
