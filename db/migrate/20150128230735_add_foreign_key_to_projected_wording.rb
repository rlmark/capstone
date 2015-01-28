class AddForeignKeyToProjectedWording < ActiveRecord::Migration
  def change
    add_column :projected_wordings, :question_id, :integer
  end
end
