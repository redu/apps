module ApplicationHelper
  # Mostra todos os erros de um determinado atributo em forma de lista
  def concave_errors_for(object, method)
    errors = object.errors[method].collect do |msg|
      content_tag(:li, msg)
    end.join.html_safe

    content_tag(:ul, errors, :class => 'control-errors')
  end

  # Retorna a URL base do Redu.
  def redu_domain
    ReduApps::Application.config.redu_domain
  end

  # Retorna links simples para o Redu.
  def redu_static(area)
    redu_domain + area
  end

  # Retorna links relacionados a usuários para o Redu.
  def redu_user_static(area = "", user = current_user)
    redu_domain + "pessoas/" + user.login + "/" + area
  end
end
