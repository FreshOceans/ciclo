class CreateCountyTrails < ActiveRecord::Migration[5.1]
  def change
    create_table :county_trails do |t|
      t.references :county, foreign_key: true
      t.references :trail, foreign_key: true

      t.timestamps
    end
  end
end

# < ======= county_id, trail_id ======= >
