class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.string :device_type, null: false
      t.string :ip_address, null: false
      t.timestamps
    end

    add_index :sessions, :session_token, unique: true
  end
end
