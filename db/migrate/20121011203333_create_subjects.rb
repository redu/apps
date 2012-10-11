class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :suid
      t.string :name
      t.belongs_to :space

      t.timestamps
    end
    add_index :subjects, [:suid, :name, :space_id]
  end
end
