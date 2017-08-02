class CreateTrailTags < ActiveRecord::Migration[5.1]
  def change
    create_table :trail_tags do |t|
      t.references :trail, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end

# < ======= trail_id, tag_id ======= >
