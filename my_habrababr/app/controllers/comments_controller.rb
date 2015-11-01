class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
    set_comment
  end

  def new
    @comment = Comment.new
  end

  def edit
    set_comment
  end

  def create
    @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to @comment
      else
        render :new
      end
    end

  def update
    set_comment
      if @comment.update(comment_params)
        redirect_to @comment
      else
        render :edit
      end
  end

  def destroy
    set_comment
    @comment.destroy

    redirect_to comments_path
  end


  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
