class AddZombieToEnvironments < ActiveRecord::Migration
  def change
    add_column :environments, :zombie, :boolean
  end
end
