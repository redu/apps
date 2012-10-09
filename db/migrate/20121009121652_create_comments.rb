class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :app
      t.text :body

      t.timestamps
    end
    add_index :comments, [:user_id, :app_id]
  end
end
