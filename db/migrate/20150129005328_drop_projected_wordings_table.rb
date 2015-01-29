class DropProjectedWordingsTable < ActiveRecord::Migration
  def change
    drop_table :projected_wordings
  end
end
