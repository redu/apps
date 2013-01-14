module UserAbility
  extend ActiveSupport::Concern

  def user_abilities(user)
    if user
      can :manage, User do |u|
        u.id == user.id || user.is_admin?
      end
    end
  end
end
