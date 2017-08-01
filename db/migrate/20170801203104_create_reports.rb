class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.integer :surface_rating
      t.integer :traffic_rating
      t.integer :scenery_rating
      t.integer :overall_rating
      t.text :comment

      t.timestamps
    end
  end
end
