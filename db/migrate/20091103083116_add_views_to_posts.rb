class AddViewsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :views, :integer
  end

  def self.down
    remove_column :posts, :views
  end
end
