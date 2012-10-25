class CreateUserCourseAssociations < ActiveRecord::Migration
  def change
    create_table :user_course_associations do |t|
      t.references :user, :course

      t.timestamps
    end
    add_index :user_course_associations, [:user_id, :course_id]
  end
end
