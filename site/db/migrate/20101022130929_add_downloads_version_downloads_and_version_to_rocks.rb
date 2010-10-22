class AddDownloadsVersionDownloadsAndVersionToRocks < ActiveRecord::Migration
  def self.up
    add_column :rocks, :downloads, :integer
    add_column :rocks, :version_downloads, :integer
    add_column :rocks, :version, :string
  end

  def self.down
    remove_column :rocks, :version
    remove_column :rocks, :version_downloads
    remove_column :rocks, :downloads
  end
end
