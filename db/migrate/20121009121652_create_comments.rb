class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :app
      t.belongs_to :in_response_to
      t.text :body
      t.integer :type_cd, default: 0

      t.timestamps
    end
    add_index :comments, [:user_id, :app_id, :in_response_to_id, :type_cd], 
      :name => 'index_comments_on_user_and_app_and_type_columns'
  end
end
