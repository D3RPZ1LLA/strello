class CatagoriesController < ApplicationController
  before_filter :logged_in_clearance
  # needs member clearance

  def new
    @board = Board.find(params[:board_id])
    @catagory = Catagory.new
    render :new
  end

  def create
    @board = Board.find_by_id(params[:board_id])
    @catagory = Catagory.new(
      title: params[:catagory][:title],
      sort_idx: params[:catagory][:sort_idx],
      board_id: params[:board_id]
    )
    p @catagory
    if @catagory.save
      if request.xhr?
        render json: @catagory
      else
        redirect_to board_url(params[:board_id])
      end
    else
      p @catagory.errors.full_messages
      if request.xhr?
        render json: @catagory
      else
        flash[:errors] = @catagory.errors.full_messages
        render :new
      end
    end
  end
  
  def update
    @catagory = Catagory.find(params[:id])
    if @catagory.update_attributes(params[:catagory])
      if request.xhr?
        render json: @catagory
      else
        redirect_to board_url(params[:board_id])
      end
    else
      if request.xhr?
        head status: 422
      else
        redirect_to root_url
      end
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
  
  def reorder
    if request.xhr?      
      ActiveRecord::Base.connection.execute(Catagory.generate_reorder(params[:catagories], current_user.id))
      head status: 200
    else
      redirect_to root_url
    end
  end
end
