class Usergroup < ActiveRecord::Migration
  def self.up
    create_table :usergroups do |t|
      t.string :name
      t.text :body

      t.timestamps
    end	
  end

  def self.down
    drop_table :usergroups
  end
end