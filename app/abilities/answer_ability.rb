module AnswerAbility
  extend ActiveSupport::Concern

  def answer_abilities(user)
    can :read, Answer
  end
end
