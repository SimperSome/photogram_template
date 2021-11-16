class AddRecipientReferenceToFollowRequests < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :follow_requests, :users, column: :recipient_id
    add_index :follow_requests, :recipient_id
    change_column_null :follow_requests, :recipient_id, false
  end
end
