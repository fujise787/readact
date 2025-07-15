class ApplicationController < ActionController::Base
  before_action :set_categories, if: :user_signed_in?

  private

  def set_categories
    # ユーザーごとにカテゴリを取得
    @categories = current_user ? current_user.categories : Category.all
  end
end
