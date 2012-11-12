module AppsHelper
  def filters_url(filters, category)
    ret = filters + [category.id.to_s] - (filters & [category.id.to_s])

    if ret.length == 0 || ret.length == 5 # Quantidade máximo de filtros
      nil
    else
      ret
    end
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
end
