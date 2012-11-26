class RemoveAidFromApps < ActiveRecord::Migration
  def up
    remove_column :apps, :aid
  end

  def down
    add_column :apps, :aid, :integer
  end
end
