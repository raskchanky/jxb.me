class AddNumAndLongUrlToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :key, :integer
    add_column :sites, :long_url, :text
  end

  def self.down
    remove_column :sites, :long_url
    remove_column :sites, :key
  end
end
