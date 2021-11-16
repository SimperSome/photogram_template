class AddOwnPhotoCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :own_photos_count, :integer
  end
end
