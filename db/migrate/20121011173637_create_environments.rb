class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.integer :eid
      t.string :name
      t.belongs_to :user
      t.attachment :thumbnail
      t.boolean :zombie
      t.timestamps
    end
    add_index :environments, [:eid, :name, :user_id]
  end
end
