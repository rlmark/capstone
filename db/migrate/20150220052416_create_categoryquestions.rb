class CreateCategoryquestions < ActiveRecord::Migration
  def change
    create_table :categoryquestions do |t|
      t.integer :category_id
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
