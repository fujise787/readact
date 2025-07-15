class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      respond_to do |format|
        format.json { render json: @category, status: :created }
        format.turbo_stream
      end
      flash[:notice] = "カテゴリを登録しました"
    else
      render json: @category.errors, status: :unprocessable_entity
      flash[:alert] = "カテゴリの登録に失敗しました"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
