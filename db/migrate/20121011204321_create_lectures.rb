class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.integer :lid
      t.string :name
      t.belongs_to :subject
      t.belongs_to :app
      t.string :lectureable_type
      t.integer :lectureable_id

      t.timestamps
    end
    add_index :lectures, [:lid, :name, :subject_id]
  end
end
