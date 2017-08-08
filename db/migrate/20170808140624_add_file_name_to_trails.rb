class AddFileNameToTrails < ActiveRecord::Migration[5.1]
  def change
    add_column :trails, :filename, :string
  end
end
