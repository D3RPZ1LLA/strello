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
    unless @board = Board.find_by_id(params[:board_id])
      flash[:errors] = "Board not fonud"
      redirect_to user_url(current_user)
    else
      @card = Card.new(params[:card])
      begin
        ActiveRecord::Base.transaction do
          params[:checklist_items].reject! { |v| v.all? { |_, v2| v2 == "" } }


          @checklist_items = params[:checklist_items].map do |item_params|
            ChecklistItem.new(item_params)
          end

          @card.board_id = @board.id
          @card.save

          @checklist_items.each do |item|
            item.card_id = @card.id
            item.save
          end

          raise "invalid" unless @checklist_items.length > 0
          raise "invalid" unless @card.valid? && @checklist_items.all? { |item| item.valid? }
        end

      rescue
        render :new
      else
        redirect_to board_url(@board)
      end
    end
  end

  def show
    if @card = Card.includes(:checklist_items).find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "Card not found"
      redirect_to user_url(current_user)
    end
  end

  def edit
    if @card = Card.includes(:checklist_items).find_by_id(params[:id])
      render :edit
    else
      flash[:errors] = "Card not found"
      redirect_to user_url(current_user)
    end
  end

  def update
    if @card = Card.find_by_id(params[:id])
      if @card.update_attributes(params[:card])
        redirect_to board_url(@card.board_id)
      else
        render :edit
      end
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
