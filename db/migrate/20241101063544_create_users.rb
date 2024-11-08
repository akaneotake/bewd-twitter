class CreateUsers < ActiveRecord::Migration[6.1]
  def change    
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false  # Use password_digest instead of password
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
