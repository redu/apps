# enconding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :root, 'Portal de Aplicativos (Recursos Educacionais Abertos)',
      root_path,
      class: "breadcrumb-mini-link icon-apps-portal-lightblue_16_18-before"

    primary.item :portal, 'Portal de Aplicativos (Recursos Educacionais Abertos)',
                 apps_path,
                 class: "breadcrumb-mini-link icon-apps-portal-lightblue_16_18-before",
                 alt_class: "breadcrumb-mini-link icon-apps-portal-lightblue_16_18-before text-replacement" do |portal|
      portal.item :app, 'Recurso Educacional Aberto', app_path(@app || 0),
                  class: "breadcrumb-mini-link icon-oer-lightblue_16_18-before"
      portal.item :search, 'Busca de Aplicativos', apps_path,
                  unless: Proc.new { !params.has_key? :search },
                  class: "breadcrumb-mini-link icon-magnifier-lightblue_16_18-before"
      portal.item :favorites, 'Aplicativos Favoritos',
                  user_favorites_path(current_user),
                  class: "breadcrumb-mini-link icon-favorite-lightblue_16_18-before"
    end
  end
end
