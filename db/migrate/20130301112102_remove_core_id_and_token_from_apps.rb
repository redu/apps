class RemoveCoreIdAndTokenFromApps < ActiveRecord::Migration
  def up
    remove_column :apps, :core_id
    remove_column :apps, :token
  end

  def down
    add_column :apps, :core_id, :string
    add_column :apps, :token, :string
  end
end
