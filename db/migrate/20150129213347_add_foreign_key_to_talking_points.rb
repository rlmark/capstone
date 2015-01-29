class AddForeignKeyToTalkingPoints < ActiveRecord::Migration
  def change
    add_column :talking_points, :question_id, :integer
  end
end
