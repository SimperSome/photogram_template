class AddPhotoReferenceToLikes < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :likes, :photos
    add_index :likes, :photo_id
    change_column_null :likes, :photo_id, false
  end
end
