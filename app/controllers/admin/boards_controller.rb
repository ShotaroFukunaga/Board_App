class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[edit update destroy show]
  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: :true).includes(:user).order(created_at: :desc).page(params[:page])
  end
  
  def show ;end

  def edit ;end

  def update
    if @board.update(board_params)
      redirect_to admin_board_path, success:  t('defaults.message.update', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_update', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to admin_boards_path, success: t('defaults.message.delete', item: Board.model_name.human)
  end

  private
  
  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
