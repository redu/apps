class RefactorIndexes < ActiveRecord::Migration
  def change
    # Comments
    remove_index :comments,
      :name => 'index_comments_on_user_and_app_and_type_columns'
    add_index :comments, :app_id
    add_index :comments, :in_response_to_id

    # AppCategoryAssociations
    remove_index :app_category_associations,
      :name => 'index_app_category_associations_on_app_id_and_category_id'
    add_index :app_category_associations, :app_id
    add_index :app_category_associations, :category_id

    # UserAppAssociations
    remove_index :user_app_associations,
      :name => 'index_user_app_associations_on_user_id_and_app_id'
    add_index :user_app_associations, :user_id
    add_index :user_app_associations, :app_id

    # Environments
    remove_index :environments,
      :name => 'index_environments_on_core_id_and_name_and_user_id'
    add_index :environments, :core_id
    add_index :environments, :user_id

    # UserEnvironmentAssociation
    remove_index :user_environment_associations,
      :name => 'index_user_environment_associations_on_user_and_environment_ids'
    add_index :user_environment_associations, :user_id
    add_index :user_environment_associations, :environment_id

    # Courses
    remove_index :courses, :name => 'index_courses_on_core_id_and_name_and_user_id'
    add_index :courses, :core_id
    add_index :courses, :user_id
    add_index :courses, :environment_id

    # UserCourseAssociations
    remove_index :user_course_associations,
      :name => 'index_user_course_associations_on_user_id_and_course_id'
    add_index :user_course_associations, :user_id
    add_index :user_course_associations, :course_id

    # Spaces
    remove_index :spaces, :name => 'index_spaces_on_core_id_and_name_and_course_id'
    add_index :spaces, :core_id
    add_index :spaces, :course_id

    # Subjects
    remove_index :subjects, :name => 'index_subjects_on_core_id_and_name_and_space_id'
    add_index :subjects, :core_id
    add_index :subjects, :space_id

    # Lectures
    remove_index :lectures, :name => 'index_lectures_on_core_id_and_name_and_subject_id'
    add_index :lectures, :core_id
    add_index :lectures, :subject_id
  end
end
