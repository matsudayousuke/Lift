class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name, :limit => 20
      t.string :last_name, :limit => 20
      t.string :user_name, :limit => 20
      t.string :encrypted_password
      t.string :salt
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
