class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    # ユーザーごとにカテゴリ名が一意になるよう制約
    add_index :categories, [:user_id, :name], unique: true
  end
end