module SpaceAbility
  extend ActiveSupport::Concern

  def space_abilities(user)
    if user
      can :manage, Space do |space|
        assoc = UserCourseAssociation.find_by_user_id_and_course_id(user, space.course)
        assoc.environment_admin? || assoc.teacher?
      end
    end
  end
end
