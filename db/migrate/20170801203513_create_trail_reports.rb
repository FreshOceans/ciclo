class CreateTrailReports < ActiveRecord::Migration[5.1]
  def change
    create_table :trail_reports do |t|
      t.references :trail, foreign_key: true
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end
