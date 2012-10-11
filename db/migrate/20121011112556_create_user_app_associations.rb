class CreateUserAppAssociations < ActiveRecord::Migration
  def change
    create_table :user_app_associations do |t|
      t.references :user, :app
      t.timestamps
    end
    add_index :user_app_associations, [:user_id, :app_id]
  end
end
