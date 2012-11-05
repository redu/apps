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
end
