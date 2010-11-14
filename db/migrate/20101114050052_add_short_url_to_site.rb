class AddShortUrlToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :short_url, :string
    add_index :sites, :short_url
  end

  def self.down
    remove_index :sites, :short_url
    remove_column :sites, :short_url
  end
end
