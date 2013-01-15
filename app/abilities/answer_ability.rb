module AnswerAbility
  extend ActiveSupport::Concern

  def answer_abilities(user)
    can :read, Answer

    if user
      can :create, Comment
      unless user.is_admin?
        cannot :create, Comment do |comment|
          comment.specialized? && !user.specialist?
        end
      end

      can :manage, Comment do |comment|
        comment.author == user || user.is_admin?
      end
    end
  end
end
