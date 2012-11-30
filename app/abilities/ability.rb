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
    methods.select { |m| m =~ /.+_abilities$/ }.each do |m|
      send(m, user)
    end
  end
end
