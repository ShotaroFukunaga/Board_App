class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:user).order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def destroy
  end
end
