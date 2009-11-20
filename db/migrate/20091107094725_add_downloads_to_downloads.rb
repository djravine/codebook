class AddDownloadsToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :downloads, :integer
  end

  def self.down
    remove_column :downloads, :downloads
  end
end
