class ChangeTypecdToKindcdOnComments < ActiveRecord::Migration
  def change
    rename_column :comments, :type_cd, :kind_cd
    rename_index :users, 'index_comments_on_user_and_app_and_type_columns', 'index_comments_on_user_and_app_and_kind_columns'
  end
end
