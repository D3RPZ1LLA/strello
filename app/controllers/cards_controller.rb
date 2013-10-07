class CardsController < ApplicationController
  before_filter :logged_in_clearance

  def create
    #add transaction to build taggings
    @card = Card.new(params[:card])
    @card.board_id = params[:board_id]
    if @card.save
      redirect_to card_url(@card)
    else
      redircet_to catagory_url(params[:catagroy_id])
    end
  end

  def show
    if @card = Card.find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "Card not found"
      redirect_to user_url(current_user)
    end
  end

  def destroy
    if @card = Card.find_by_id(params[:id])
      @card.destroy
    else
      flash[:errors] = "Card not found"
    end
    redirect_to user_url(current_user)
  end
end
