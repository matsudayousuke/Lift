class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.column :date, :date
      t.column :body, :text
      t.references :objective
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
