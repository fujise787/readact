class CreateActions < ActiveRecord::Migration[7.2]
  def change
    create_table :actions do |t|
      t.references :note, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end