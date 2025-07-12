class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index ; end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      flash[:notice] = "カテゴリを登録しました"
    else
      flash[:alert] = "カテゴリの登録に失敗しました"
    end
    redirect_back fallback_location: root_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
