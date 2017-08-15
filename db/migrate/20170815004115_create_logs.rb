class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true
      t.string :git
      t.string :status

      t.timestamps
    end
  end
end
