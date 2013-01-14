module UserSessionAbility
  extend ActiveSupport::Concern

  def user_session_abilities(user)
    if user
      can :destroy, UserSession do |user_session|
        user_session.user == user || user.is_admin?
      end
    end
  end
end
