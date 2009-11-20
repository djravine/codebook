class AddTitleToDownloads < ActiveRecord::Migration
  def self.up
    add_column :downloads, :title, :string
  end

  def self.down
    remove_column :downloads, :title
  end
end
