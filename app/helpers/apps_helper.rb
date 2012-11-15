# encoding: utf-8
module AppsHelper
  def filters_url(filters, category)
    ret = filters + [category.id.to_s] - (filters & [category.id.to_s])

    if ret.length == 0 || ret.length == 5 # Quantidade máximo de filtros
      nil
    else
      ret
    end
  end

  # Retorna a quantidade de aplicativos encontrados de uma dada categoria.
  def count_filtered(filters_counter, cat)
    if params.include? :search
      filters_counter[cat.name].to_i
    else
      0
    end
  end

  def filter_class(filters, category)
    if filters.include? category.id.to_s
      "filter filter-active"
    else
      "filter"
    end
  end

  # Chama join para um array de entidades que possuem name
  def names_for(entities)
    entities.collect(&:name).join(", ")
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

  # Conta os comentários de uma aplicação (comuns + respostas)
  def count_comments_for(app)
    Comment.get_by_type(app, :common).length + Comment.get_by_type(app, :answer).length
  end
end
