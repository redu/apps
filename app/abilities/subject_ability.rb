module SubjectAbility
  extend ActiveSupport::Concern

  def subject_abilities(user)
    if user
      can :create, Subject do |subject|
        roles = [ UserCourseAssociation.environment_admin,
          UserCourseAssociation.teacher ]

        UserCourseAssociation.where(course_id: subject.space.course_id,
          user_id: user.id, role_cd: roles).exists?
      end
    end
  end
end