class CreateUserEnvironmentAssociations < ActiveRecord::Migration
  def change
    create_table :user_environment_associations do |t|
      t.references :user, :environment

      t.timestamps
    end
    add_index :user_environment_associations, [:user_id, :environment_id],
      :name => 'index_user_environment_associations_on_user_and_environment_ids'
  end
end
