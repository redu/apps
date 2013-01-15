module AnswerAbility
  extend ActiveSupport::Concern

  def answer_abilities(user)
    can :read, Answer

    if user
      can :create, Answer

      can :manage, Answer do |answer|
        answer.author == user || user.is_admin?
      end
    end
  end
end
