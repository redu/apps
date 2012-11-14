class AddZombieToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :zombie, :boolean
  end
end
