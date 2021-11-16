class AddLikeCountToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :likes_count, :integer
  end
end
