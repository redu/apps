module UserSessionAbility
  extend ActiveSupport::Concern

  def user_session_abilities(user)
    if user
      can :destroy, UserSession do |user_session|
        user_session.user == user
      end
    end
  end
end
