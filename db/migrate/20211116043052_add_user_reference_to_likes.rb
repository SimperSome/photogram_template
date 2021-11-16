class AddUserReferenceToLikes < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :likes, :users
    add_index :likes, :user_id
    change_column_null :likes, :user_id, false
  end
end
