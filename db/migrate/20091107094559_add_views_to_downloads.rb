class AddViewsToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :views, :integer
  end

  def self.down
    remove_column :downloads, :views
  end
end
