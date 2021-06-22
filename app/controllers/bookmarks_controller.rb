class BookmarksController < ApplicationController
    
    #before_action :set_board, only: %i[create destroy]
    #before_action :require_login, only: %i[destroy create]

    
    def create
        board = Board.find(params[:board_id])
        
        current_user.bookmark(board)
        redirect_back fallback_location: root_path, success: t('.success')

    def destroy
        board = current_user.bookmark.find_by(params[:id]).board.current_user.unbookmark(board)
        redirect_back fallback_location: root_path, success: t('.success')
    end

    private

    def set_board
        @board = Board.find(params[:board_id])
    end
end

