module UserAbility
  extend ActiveSupport::Concern

  def user_abilities(user)
    if user
      can :manage, User, id: user.id
    end
  end
end
