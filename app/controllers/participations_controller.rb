class ParticipationsController < ApplicationController
  def new
    @card = Card.includes(catagory: [board: :members]).find(params[:card_id])
    render :new
  end

  def create
    @card = Card.includes(catagory: [board: :members]).find(params[:card_id])
    @participation = Participation.new(params[:participation])
    @participation.card_id = params[:card_id]
    if @participation.save
      redirect_to edit_card_url(params[:card_id])
    else
      render :new
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
