class Ability
  include CanCan::Ability

  include AppAbility
  include UserAppAssociationAbility
  include CommentAbility
  include UserAbility
  include UserSessionAbility

  def initialize(user)
    execute_rules(user)
  end

  protected

  def execute_rules(user)
    can :manage, :all if user.try(:is_admin?)

    methods.select { |m| m =~ /.+_abilities$/ }.each do |m|
      send(m, user)
    end
  end
end
