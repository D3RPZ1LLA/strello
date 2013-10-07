class ChecklistItemsController < ApplicationController
  def create
    @checklist_item = ChecklistItem.new(params[:checklist_item])
    @checklist_item.card_id = params[:card_id]
    if @checklist_item.save
      redirect_to card_url(:card_id)
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
