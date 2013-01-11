class AddCoreRoleColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :core_role, :integer, :default => 2 # member
  end
end
