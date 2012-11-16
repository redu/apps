module ApplicationHelper
  # Mostra todos os erros de um determinado atributo em forma de lista
  def concave_errors_for(object, method)
    errors = object.errors[method].collect do |msg|
      content_tag(:li, msg)
    end.join.html_safe

    content_tag(:ul, errors, :class => 'control-errors')
  end
end
