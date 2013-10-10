class CardsController < ApplicationController
  before_filter :logged_in_clearance

  def new
    if @catagory = Catagory.includes(:board).find(params[:catagory_id])
      @card = Card.new
      @card.catagory = @catagory
      render :new
    else
      flash[:errors] = "Board not fonud"
      redirect_to user_url(current_user)
    end
  end

  def create
    @catagory = Catagory.includes(:board).find(params[:catagory_id])

    @card = Card.new(params[:card])
    @card.catagory_id = @catagory.id

    if @card.save
      redirect_to board_url(@catagory.board)
    else
      flash[:errors] = @card.errors.full_messages
      render :new
    end
  end

  def edit
    if @card = Card.includes({checklists: [:checklist_items]}, :participants, catagory: :board).find(params[:id])
      render :edit
    end
  end

  def update
    @card = Card.includes({checklists: [:checklist_items]}, :participants, catagory: :board).find(params[:id])

    if @card.update_attributes(params[:card])
      redirect_to board_url(@card.catagory.board)
    else
      render :edit
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
