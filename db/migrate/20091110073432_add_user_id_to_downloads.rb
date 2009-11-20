class AddUserIdToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :user_id, :integer
  end

  def self.down
    remove_column :downloads, :user_id
  end
end
