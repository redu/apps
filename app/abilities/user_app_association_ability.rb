module UserAppAssociationAbility
  extend ActiveSupport::Concern

  def user_app_association_abilities(user)
    if user
      can :create, UserAppAssociation
      can :manage, UserAppAssociation, user_id: user.id
    end
  end
end
