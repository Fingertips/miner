class CreateRocks < ActiveRecord::Migration
  def self.up
    create_table :rocks do |t|
      t.string :name
      t.text :authors
      t.text :description
      t.integer :score
      t.timestamps
    end
    add_index :rocks, :name, :unique => true
  end
  
  def self.down
    drop_table :rocks
  end
end
