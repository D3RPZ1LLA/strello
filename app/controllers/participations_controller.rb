class ParticipationsController < ApplicationController
  def new
    @card = Card.includes(:participants).find(params[:card_id])
    render :new
  end

  def create
    @participation = Participation.new(params[:participation])
    if @participation.save
      redirect_to user_url(current_user)
    else
      redirect_to user_url(current_user)
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
