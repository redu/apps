class AddZombieToUserCourseAssociation < ActiveRecord::Migration
  def change
    add_column :user_course_associations, :zombie, :boolean
  end
end
