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
          avatar_url: @user.avatar.url(:thumb),
          participation: @participation
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
    # id is the user id not participation, needs to look up by user id and card id
    if @participation = Participation.find(params[:id])
      @participation.destroy
      if request.xhr?
        head status: 200
      else
        redirect_to root_url
      end
    else
      if request.xhr?
        head status: 422
      else
        redirect_to root_url
      end
    end
  end
end
