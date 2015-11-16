class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :user_check, only: [:edit, :update, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

      if @comment.save
        redirect_to @post, notice: 'Комментарий успешно создан'
      else
        render :new
      end
    end

  def update
      if @comment.update(comment_params)
        redirect_to @comment.post, notice: 'Комментарий успешно обновлён'
      else
        render :edit
      end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.post, notice: 'Комментарий успешно удалён'
  end


  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end

  def user_check
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to posts_path, notice: 'У вас нет прав на выполнение этого действия'
    end
  end
end
