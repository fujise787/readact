class NotesController < ApplicationController
  def new
    @note = Note.new
    @note.build_highlight
    @note.build_summary
    @note.actions.build
  end

  def create
    unless user_signed_in?
      flash.now[:alert] = "ログインしてください"
      return
    end

    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to new_note_path, notice: 'ノートが保存されました'
    else
      # エラー時に必要なアソシエーションを再構築
      @note.build_highlight unless @note.highlight
      @note.build_summary unless @note.summary
      @note.actions.build if @note.actions.empty?
      
      flash.now[:alert] = "保存に失敗しました: #{@note.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = current_user.notes.includes(:highlight, :summary, :actions).find(params[:id])
    load_categories
  end

  def update
    @note = current_user.notes.find(params[:id])
    @note.assign_attributes(note_params)

    if @note.save
      redirect_to @note, notice: "ノートが保存されました"
    else
      flash.now[:alert] = "保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def note_params
    params.require(:note).permit(
      :title, :category_id,
      highlight_attributes: [:id, :content],
      summary_attributes: [:id, :content],
      actions_attributes: [:id, :content, :_destroy]
    )
  end

  def load_categories
    @categories = current_user.categories
  end
end
