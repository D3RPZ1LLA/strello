class CardsController < ApplicationController
  before_filter :logged_in_clearance

  def new
    if @board = Board.find_by_id(params[:board_id])
      @card = Card.new
      render :new
    else
      flash[:errors] = "Board not fonud"
      redirect_to user_url(current_user)
    end
  end

  def create
    #add transaction to build taggings
    @card = Card.new(params[:card])
    @card.board_id = params[:board_id]
    if @card.save
      redirect_to board_url(params[:board_id])
    else
      redirect_to board_url(params[:board_id])
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

  def edit
    if @card = Card.find_by_id(params[:id])
      render :edit
    else
      flash[:errors] = "Card not found"
      redirect_to user_url(current_user)
    end
  end

  def update
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
