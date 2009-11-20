class AddTagsToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :tags, :text
  end

  def self.down
    remove_column :downloads, :tags
  end
end
