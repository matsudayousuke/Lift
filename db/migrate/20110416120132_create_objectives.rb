class CreateObjectives < ActiveRecord::Migration
  def self.up
    create_table :objectives do |t|
      t.column :name, :string, :limit => 100
      t.column :description, :text
      t.column :order, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :objectives
  end
end
