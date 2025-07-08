class CreateSummaries < ActiveRecord::Migration[7.2]
  def change
    create_table :summaries do |t|
      t.references :note, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end