class AddUserIdToObjectives < ActiveRecord::Migration
  def self.up
    add_column :objectives, :user_id, :integer
  end

  def self.down
    remove_column :objectives, :user_id
  end
end
