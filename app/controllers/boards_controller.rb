class BoardsController < ApplicationController
  before_filter :logged_in_clearance
  before_filter :member_clearance, only: [:show, :pending, :finished]

  def index
    @boards = Board.includes(:members).select { |board| board.members.include?(current_user) }
    render :index
  end

  def new
    @board = Board.new
    render :new
  end

  def create
    @board = current_user.created_boards.build(params[:board])
    if @board.save
      Membership.create(user_id: current_user.id, board_id: @board.id, admin: true)
      Catagory.create(board_id: @board.id, title: "To Do", sort_idx: 0)
      Catagory.create(board_id: @board.id, title: "Doing", sort_idx: 1)
      Catagory.create(board_id: @board.id, title: "Done", sort_idx: 2)
      redirect_to board_url(@board)
    else
      redirect_to root_url
    end
  end

  def show
    if @board ||= Board.includes(:members, catagories: :cards).find_by_id(params[:id])
      render :show
    else
      flash[:errors] = "Board not found"
      redirect_to user_boards_url(current_user)
    end
  end
  
  def update
    @board = Board.find(params[:id])
    @board.update_attributes(params[:board])
    if request.xhr?
      render json: @board
    else
      redirect_to board_url(@board)
    end
  end
end
