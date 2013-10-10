class ChecklistsController < ApplicationController
  def new
    @card = Card.find(params[:card_id])
    render :new
  end

  def create
    @card = Card.find(params[:card_id])
    @checklist = Checklist.new(params[:checklist])
    @checklist.card_id = @card.id
    if @checklist.save
      redirect_to edit_card_url(@card)
    else
      render :new
    end
  end
end
