module AppAbility
  extend ActiveSupport::Concern

  def app_abilities(user)
    can :read, App
  end
end
