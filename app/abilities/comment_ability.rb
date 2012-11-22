module CommentAbility
  extend ActiveSupport::Concern

  def comment_abilities(user)
    can :read, Comment

    if user
      can :create, Comment
      cannot :create, Comment do |comment|
        comment.specialized? && !user.specialist?
      end

      can :manage, Comment, user_id: user.id
    end
  end
end
