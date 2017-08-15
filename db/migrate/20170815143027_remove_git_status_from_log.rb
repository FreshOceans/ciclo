class RemoveGitStatusFromLog < ActiveRecord::Migration[5.1]
  def change
    remove_column :logs, :git, :string
    remove_column :logs, :status, :string
  end
end
