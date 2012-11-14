class AddZombieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zombie, :boolean
  end
end
