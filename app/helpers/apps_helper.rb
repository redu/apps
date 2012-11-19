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

  # Retorna as classes corretas das screenshots do aplicativo.
  def screen_shot_class(length)
    if length == 2
      # Se existem 2 imagens.
      "oer-image-preview oer-image-preview-small"
    else
      # Se existe apenas 1 imagem.
      "oer-image-preview oer-image-preview-long"
    end
  end

  # Retorna o tamanho correto das screenshots do aplicativo.
  def screen_shot_size(length)
    if length == 2
      # Se existem 2 imagens.
      "339x200"
    else
      # Se existe apenas 1 imagem.
      "698x200"
    end
  end

  # Chama join para um array de entidades que possuem name
  def names_for(entities)
    entities.collect(&:name).join(", ")
  end

  # Retorna 2 se length for maior que 2 ou length se menor.
  def max_2_answers(length)
    if length > 2
      2
    else
      length
    end
  end

  # Verifica se a resposta da vez é a última.
  def last_answer?(index, total)
    index + 1 == total
  end
  # Conta os comentários de uma aplicação (comuns + respostas)
  def count_comments_for(app)
    Comment.get_by_type(app, :common).length + Comment.get_by_type(app, :answer).length
  end
end
