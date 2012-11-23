module LectureAbility
  extend ActiveSupport::Concern

  def lecture_abilities(user)
    if user
      can :create, Lecture do |lecture|
        roles = [ UserCourseAssociation.environment_admin,
          UserCourseAssociation.teacher ]

        UserCourseAssociation.includes(course: {spaces: :subjects}).
          where("subjects.id" => lecture.subject.id, "user_id" => user.id,
            "role_cd" => roles).exists?
      end
    end
  end
end