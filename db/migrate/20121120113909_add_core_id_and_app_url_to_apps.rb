class AddCoreIdAndAppUrlToApps < ActiveRecord::Migration
  def change
    add_column :apps, :core_id, :integer
    add_column :apps, :app_url, :string
  end
end
