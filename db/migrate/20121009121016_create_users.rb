class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :token
      t.string :login
      t.string :first_name
      t.string :last_name
      t.integer :role_cd, :default => 1
      t.attachment :thumbnail

      t.timestamps
    end
    add_index :users, [:uid]
  end
end
