class AddIndexToOwnerId < ActiveRecord::Migration
  add_index :cats, :owner_id
end
