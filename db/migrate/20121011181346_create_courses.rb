class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :cid
      t.string :name
      t.belongs_to :user
      t.belongs_to :environment

      t.timestamps
    end
    add_index :courses, [:cid, :name, :user_id]
  end
end
