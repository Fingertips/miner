class ChangeScoreToFloat < ActiveRecord::Migration
  def self.up
    change_column :rocks, :score, :float
  end

  def self.down
    change_column :rocks, :score, :integer
  end
end
