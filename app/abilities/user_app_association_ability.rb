module UserAppAssociationAbility
  extend ActiveSupport::Concern

  def user_app_association_abilities(user)
    if user
      can :create, UserAppAssociation do |user_app_assoc|
        ((user_app_assoc.user.nil? || user_app_assoc.user == user) &&
          !UserAppAssociation.exists?(user_id: user,
                                      app_id: user_app_assoc.app))
      end

      can :manage, UserAppAssociation do |user_app_assoc|
        user_app_assoc.user == user
      end
    end
  end
end
