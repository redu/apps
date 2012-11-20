class AddIndexOnCoreIdToUserCourseAssociationTable < ActiveRecord::Migration
  def change
    remove_index :user_course_associations, [:user_id, :course_id]
    add_index :user_course_associations, [:core_id, :user_id, :course_id],
      name: 'index_user_course_associations_on_core_id_and_user_and_course'
  end
end
