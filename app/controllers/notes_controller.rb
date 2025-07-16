class NotesController < ApplicationController
  def index
    unless user_signed_in?
      flash.now[:alert] = "ログインしてください"
      return
    end

    @notes = current_user.notes
  end

  def new
    if session[:note_draft]
      @note = Note.new(session[:note_draft])
      session.delete(:note_draft)
    else
      @note = Note.new
    end
    @note.build_highlight unless @note.highlight
    @note.build_summary unless @note.summary
    @note.build_action
  end

  def create
    # ログイン判定
    unless user_signed_in?
      session[:note_draft] = note_params.to_h
      flash[:alert] = "ログインしてください"
      redirect_to new_user_session_path
      return
    end

    @note = current_user.notes.build(note_params)
    if @note.save
      session.delete(:note_draft)
      redirect_to edit_note_path(@note), notice: 'ノートが保存されました'
    else
      # エラー時に必要なアソシエーションを再構築
      @note.build_highlight unless @note.highlight
      @note.build_summary unless @note.summary
      @note.build_action unless @note.action
      
      flash.now[:alert] = "保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = current_user.notes.includes(:highlight, :summary, :action).find(params[:id])
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

  def destroy
    @note = current_user.notes.find(params[:id])
    @note.destroy
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(
      :title, :category_id,
      highlight_attributes: [:id, :content],
      summary_attributes: [:id, :content],
      action_attributes: [:id, :content]
    )
  end

  def load_categories
    @categories = current_user.categories
  end
end
