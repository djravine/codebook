class AddBodyToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :body, :text
  end

  def self.down
    remove_column :downloads, :body
  end
end
