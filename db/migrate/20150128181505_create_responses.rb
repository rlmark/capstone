class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :transcript

      t.timestamps null: false
    end
  end
end
