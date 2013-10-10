class ChecklistItemsController < ApplicationController
  def new
    @checklist = Checklist.find(params[:checklist_id])
    render :new
  end

  def create
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = ChecklistItem.new(params[:checklist_item])
    @checklist_item.checklist_id = params[:checklist_id]

    if @checklist_item.save
      redirect_to edit_card_url(@checklist.card_id)
    else
      flash[:errors] = "Card invalid"
      redirect_to card_url(:card_id)
    end
  end

  def update
    if @checklist_item = ChecklistItem.find_by_id(params[:id])
      ### update here!!!
    else
      flash[:errors] = "404"
      redirect_to user_url(current_user)
    end
  end

  def destroy
    if @checklist_item = ChecklistItem.find_by_id(params[:id])
      @checklist_item.destroy
    else
      flash[:errors] = "404"
    end
    redirect_to user_url(current_user)
  end
end
