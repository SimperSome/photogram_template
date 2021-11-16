class AddCommenterReferenceToComments < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :comments, :users, column: :commenter_id
    add_index :comments, :commenter_id
    change_column_null :comments, :commenter_id, false
  end
end
