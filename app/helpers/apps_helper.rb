# encoding: utf-8
module AppsHelper
  # Gera o parâmetro filters para url de cada filtro de acordo com a computação
  # dos filtros já selecionados + o que está sendo clicado / (des)selecionado
  def filters_url(filters, category, max_filters)
    ret = filters + [category.id.to_s] - (filters & [category.id.to_s])

    # Retorna nil quando a quantidade de categorias selecionadas é 0 ou é igual
    # ao máximo de categorias possíveis (dependente de contexto)
    if ret.length == 0 || ret.length == max_filters
      nil # Desativa filtros
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

  # Retorna number_of_displayed_last_answers se length for maior que
  # number_of_displayed_last_answers ou length se menor.
  def max_answers(length, number_of_displayed_last_answers)
    if length > number_of_displayed_last_answers
      number_of_displayed_last_answers
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
    Comment.get_by_kind(app, :common).length + Comment.get_by_kind(app, :answer).length
  end

  # Retorna a classe correta dependendo do tipo de mensagem.
  def flash_message_class(type)
    case type
    when :info
      "info"
    when :notice
      "success"
    when :error
      "warning"
    end
  end

  # Retorna o título da modal de "Adicionar à Disciplina".
  def modal_title(space = nil)
    if space
      "a \"#{space.name}\""
    else
      "à Disciplina"
    end
  end

  # Retorna a classe de passo ativo para o passo atual.
  def step_active_class(step, current_step)
    " apps-portal-add-oer-step-current" if step == current_step
  end

  # Retorna "N/A" (Not Applicable) se info não existir.
  def verify_availability(info, is_link = false)
    if info.nil?
      "N/A"
    else
      if is_link
        link_to(info, info)
      else
        info
      end
    end
  end

  # Mostra o separador somente a cada 2 iterações e quando não é o último.
  def display_separator(index, total)
    (index % 2 == 0) and (index != total)
  end

  # Adiciona classe app-favorite aos aplicativos favoritos.
  def add_app_favorite_class(favorite_flag)
    "app-favorite" if favorite_flag    
  end
end
