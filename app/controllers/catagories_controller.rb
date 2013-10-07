class CatagoriesController < ApplicationController
  before_filter :logged_in_clearance
  
  def create
    # may need checks on board id
    @catagory = Catagory.new(title: params[:catagory][:title], board_id: params[:board_id])
    if @catagory.save
      redirect_to catagory_url(@catagory)
    else
      redirect_to board_url(params[:board_id])
    end
  end
  
  def edit
  end
  
  def show
    if @catagory = Catagory.includes(:board, :cards).find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "Catagory not found"
      redirect_to user_url(current_user)
    end
  end
  
  def destroy
    if @catagory = Catagory.includes(:board).find_by_id(param[:id])
      @board = @catagory.board
      if @catagory.cards.empty?
        @catagory.destroy
      else
        flash[:errors] = "cannot delete non-empty catagory"
      end
      redirect_to board_url(@board)
    else
      flash[:errors] = "Catagory not found"
      redirect_to user_url(current_user)
    end
  end
end
