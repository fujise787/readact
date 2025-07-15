class ChangeCategoryIdNullOnNotes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :notes, :category_id, true
  end
end
