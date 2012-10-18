SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :portal, 'Portal de Aplicativos (Recursos Educacionais Abertos)', 
      root_path do |portal|
      portal.item :app, 'Recurso Educacional Aberto', app_path(@app || 0)
      portal.item :search, 'Busca de Aplicativos' # TODO search
      portal.item :favorites, 'Aplicativos Favoritos', 
                  user_favorites_path(@user || 0) # TODO current_user
    end
    primary.auto_highlight = true
  end
end
