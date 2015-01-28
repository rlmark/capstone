class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.boolean :private

      t.timestamps null: false
    end
  end
end
