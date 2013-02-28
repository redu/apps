class ChangeKindDefaultOnComments < ActiveRecord::Migration
  def up
    change_column_default :comments, :kind_cd, nil
  end

  def down
    change_column_default :comments, :kind_cd, 0
  end
end
