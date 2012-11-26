class AddCoreIdAndCoreUrlToApps < ActiveRecord::Migration
  def change
    add_column :apps, :core_id, :integer
    add_column :apps, :core_url, :string
  end
end
