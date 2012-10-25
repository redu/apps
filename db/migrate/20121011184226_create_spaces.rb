class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.integer :sid
      t.string :name
      t.belongs_to :course

      t.timestamps
    end
    add_index :spaces, [:sid, :name, :course_id]
  end
end
