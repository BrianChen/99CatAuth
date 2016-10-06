class AddColumnOwnerId < ActiveRecord::Migration
  def change
    add_column :cats, :owner_id, :string, null: false
  end
end
