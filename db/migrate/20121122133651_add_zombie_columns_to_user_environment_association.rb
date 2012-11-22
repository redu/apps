class AddZombieColumnsToUserEnvironmentAssociation < ActiveRecord::Migration
  def change
    add_column :user_environment_associations, :core_id, :integer
    add_column :user_environment_associations, :zombie, :boolean
  end
end
