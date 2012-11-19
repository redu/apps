module UserAppAssociationAbility
  extend ActiveSupport::Concern

  def user_app_association_abilities(user)
    if user
      can :create, UserAppAssociation do |user_app_assoc|
        !UserAppAssociation.exists?(user_id: user, app_id: user_app_assoc.app)
      end

      can :manage, UserAppAssociation, user_id: user.id
    end
  end
end
