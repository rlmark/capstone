class CreateTalkingPoints < ActiveRecord::Migration
  def change
    create_table :talking_points do |t|
      t.string :phrase

      t.timestamps null: false
    end
  end
end
