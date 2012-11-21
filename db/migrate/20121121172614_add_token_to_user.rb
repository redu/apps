class AddTokenToUser < ActiveRecord::Migration
  def change
    add_column :apps, :token, :string
  end
end
