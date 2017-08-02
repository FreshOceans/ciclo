class CreateTrails < ActiveRecord::Migration[5.1]
  def change
    create_table :trails do |t|
      t.integer :csv_id
      t.string :name
      t.float :length
      t.string :surface
      t.float :surface_rating
      t.float :traffic_rating
      t.float :scenery_rating
      t.float :overall_rating

      t.timestamps
    end
  end
end

# < ======= csv_id, name, length, surface, surface_ratingm traffic_rating, scenery_rating, overall_rating ======= >
