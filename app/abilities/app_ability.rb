module AppAbility
  extend ActiveSupport::Concern

  def app_abilities(user)
    can :read, App

    if user
      can :rate, App
      can :checkout, App
    end
  end
end
