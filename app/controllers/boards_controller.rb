class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:user).order(created_at: :desc)
  end

  def new; end

  def create
    @borad = current_user.boards.build(board_params)

    if @board.save
      redirect_to boards_path, success: t('.success')
    else
      render :index
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
