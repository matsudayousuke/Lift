class CreateObjectiveTags < ActiveRecord::Migration
  def self.up
    create_table :objective_tags do |t|
      t.integer :objective_id
      t.integer :tag_id
      t.timestamps
    end
  end

  def self.down
    drop_table :objective_tags
  end
end
