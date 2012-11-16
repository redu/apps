class AddAuthlogicColumnsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string    :crypted_password
      t.string    :password_salt
      t.string    :email
      t.string    :persistence_token

      t.index :persistence_token
    end
  end
end
