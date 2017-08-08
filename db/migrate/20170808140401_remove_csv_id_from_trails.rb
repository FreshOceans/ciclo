class RemoveCsvIdFromTrails < ActiveRecord::Migration[5.1]
  def change
    remove_column :trails, :csv_id, :integer
  end
end
