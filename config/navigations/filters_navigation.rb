# enconding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'filters'

    categories = @categories || @favorite_apps_filters

    categories.uniq.each do |category|
      # Modifica o texto do filtro (que deve exibir a quantidade de aplicativos
      # pertencentes a ele) e sua URL caso ele esteja sendo renderizado na página
      # de aplicativos favoritos
      if controller_name == 'favorites'
        counter = parentize(@favorite_apps_filters_counter[category.name]).to_s
        url = user_favorites_path(current_user,
          filter: filters_url(@filter, category,
                              @favorite_apps_filters_counter.length))
      end

      primary.item category.name.to_sym, "#{category.name} #{counter}",
        url || apps_path(filter: filters_url(@filter, category, categories.length),
                         search: @search),
        class: filter_class(@filter, category)
    end
  end
end
