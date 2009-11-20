class AddDownloadIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :download_id, :integer
  end

  def self.down
    remove_column :comments, :download_id
  end
end
