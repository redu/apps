class RenameExternalIdColumnToCoreId < ActiveRecord::Migration
  def change
    # Renomeia colunas
    rename_column :users, :uid, :core_id
    rename_column :environments, :eid, :core_id
    rename_column :courses, :cid, :core_id
    rename_column :spaces, :sid, :core_id
    rename_column :subjects, :suid, :core_id
    rename_column :lectures, :lid, :core_id
    rename_column :user_course_associations, :ucaid, :core_id

    # Renomeia índices
    rename_index :users, 'index_users_on_uid', 'index_users_on_core_id'
    rename_index :environments, 'index_environments_on_eid_and_name_and_user_id',
                 'index_environments_on_core_id_and_name_and_user_id'
    rename_index :courses, 'index_courses_on_cid_and_name_and_user_id',
                 'index_courses_on_core_id_and_name_and_user_id'
    rename_index :spaces, 'index_spaces_on_sid_and_name_and_course_id',
                 'index_spaces_on_core_id_and_name_and_course_id'
    rename_index :subjects, 'index_subjects_on_suid_and_name_and_space_id',
                 'index_subjects_on_core_id_and_name_and_space_id'
    rename_index :lectures, 'index_lectures_on_lid_and_name_and_subject_id',
                 'index_lectures_on_core_id_and_name_and_subject_id'
  end
end
