class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :token
      t.string :login
      t.string :first_name
      t.string :last_name
      t.integer :role_cd

      t.timestamps
    end
    add_index :users, [:uid]

    create_table :apps_users do |t|
      t.references :user, :app
    end
    add_index :apps_users, [:user_id, :app_id]
  end
end
