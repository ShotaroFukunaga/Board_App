class CommentsController < ApplicationController
    before_action :set_comment, only: %i[destroy update]
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  def update
    if @comment.update(comment_update_params)
      render json: { comment: @comment }, status: :ok
    else
      render json: { comment: @comment, errors: { messages: @comment.errors.full_messages} }, status: :bad_request
    end
  end

  private
  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
  
  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
