class CreateScreenShots < ActiveRecord::Migration
  def change
    create_table :screen_shots do |t|
      t.belongs_to :app
      t.attachment :screen

      t.timestamps
    end
    add_index :screen_shots, :app_id
  end
end
