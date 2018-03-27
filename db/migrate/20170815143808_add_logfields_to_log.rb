class AddLogfieldsToLog < ActiveRecord::Migration[5.1]
  def change
    add_column :logs, :daily, :boolean
    add_column :logs, :monthly, :boolean
    add_column :logs, :halfyear, :boolean
    add_column :logs, :annual, :boolean
    add_column :logs, :comment, :string
  end
end
