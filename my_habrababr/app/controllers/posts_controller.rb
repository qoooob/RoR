class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :user_check, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :user_check]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        redirect_to @post, notice: 'Пост успешно создан'
      else
        render :new
      end
  end

  def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Пост успешно обнавлён'
      else
        render :edit
      end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Пост успешно удалён'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, category_ids: [])
    end

  def user_check
    @post = Post.find(params[:id])
    unless @post.user = current_user
      redirect_to posts_url, notice: 'У вас нет прав на выполнение этого действия'
    end
  end
end
