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
      if request.xhr?
        render json: @card
      else
        redirect_to board_url(@catagory.board)
      end
    else
      flash[:errors] = @card.errors.full_messages
      render :new
    end
  end

  def show
    @card = Card.find(params[:id])
    
    if request.xhr?
      render json: {
        card: @card.as_json( include: [
          :checklists,
          :checklist_items,
          :catagory,
          :participations,
          :board
        ]),
        members: @card.members.map { |member| {member: member, avatar_url: member.avatar.url(:thumb)} },
        participants: @card.participants.map { |participant| {participant: participant, avatar_url: participant.avatar.url(:thumb)} }
      }
    else
      render :show
    end
  end

  def update
    @card = Card.includes({checklists: [:checklist_items]}, :participants, catagory: :board).find(params[:id])

    if @card.update_attributes(params[:card])
      if request.xhr?
        render json: @card
      else
        redirect_to board_url(@card.catagory.board)
      end
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
  
  def reorder
    if request.xhr?
      ActiveRecord::Base.connection.execute(Card.generate_reorder(params[:cards], current_user.id))
      head status: 200
    else
      redirect_to root_url
    end
  end
end
