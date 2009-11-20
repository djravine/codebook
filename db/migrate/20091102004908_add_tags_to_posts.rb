class AddTagsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :tags, :text
  end

  def self.down
    remove_column :posts, :tags
  end
end
