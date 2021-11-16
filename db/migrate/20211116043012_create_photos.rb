class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :caption
      t.string :image
      t.integer :owner_id
      t.string :location

      t.timestamps
    end
  end
end
