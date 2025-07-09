class CategoriesController < ApplicationController
  before_action :set_categories

  def index ; end

  def create
    @category = Category.new(category_params)
    unless @category.save
      flash.now[:alert] = "カテゴリの登録に失敗しました"
    end
  end

  private

  def set_categories
    @categories = Category.all
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
