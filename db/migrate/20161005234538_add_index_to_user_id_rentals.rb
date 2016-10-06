class AddIndexToUserIdRentals < ActiveRecord::Migration
  add_index :cat_rental_requests, :user_id
end
