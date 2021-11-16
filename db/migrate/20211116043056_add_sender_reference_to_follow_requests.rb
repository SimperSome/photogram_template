class AddSenderReferenceToFollowRequests < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :follow_requests, :users, column: :sender_id
    add_index :follow_requests, :sender_id
    change_column_null :follow_requests, :sender_id, false
  end
end
