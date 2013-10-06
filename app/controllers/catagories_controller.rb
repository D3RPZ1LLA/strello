class CatagoriesController < ApplicationController
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
    if @catagory = Catagory.includes(:board).find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "Catagory not found"
      redirect_to user_url(current_user)
    end
  end
  
  def destroy
  end
end
