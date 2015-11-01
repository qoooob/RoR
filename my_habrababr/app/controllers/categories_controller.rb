class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    set_category
  end

  def edit
    set_category
  end

  def update
    set_category

    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    set_category
    @category.destroy

    redirect_to categories_path
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end