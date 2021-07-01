class BoardsController < ApplicationController

  before_action :set_board, only: %i[destroy edit update]
  
  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    
    @board = current_user.boards.build(board_params)

    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit;end

  def update
    if @board.update(board_params)
      redirect_to board_path, success: t('defaults.message.update', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_update', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, success: t('defaults.message.delete', item: Board.model_name.human)
  end

  def bookmarks
    @search = current_user.bookmarks_boards.ransack(params[:q])
    @bookmark_boards = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end


  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
    
  end
end
