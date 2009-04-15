class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login
      t.string :crypted_password
      t.string :salt
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_update_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end