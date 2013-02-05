# enconding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.selected_class = 'text-replacement'
    primary.dom_class = 'breadcrumb-mini'
    primary.item :portal, 'Portal de Aplicativos (Recursos Educacionais Abertos)',
                 apps_path,
                 highlights_on: Proc.new { # regras de ocultação do nome
                   controller_name == 'favorites' ||
                   (controller_name == 'apps' && action_name == 'show') ||
                   params.has_key?(:search)
                 },
                 class: "breadcrumb-mini-item icon-arrow-right-separator-gray_16_18-after",
                 link: { class: 'breadcrumb-mini-link icon-apps-portal-lightblue_16_18-before' }
    primary.item :app, 'Recurso Educacional Aberto', app_path(@app || 0),
                 highlights_on: Proc.new { false }, # nunca oculta o nome
                 class: "breadcrumb-mini-link icon-oer-lightblue_16_18-before",
                 if: Proc.new { controller_name == 'apps' && action_name == 'show' }
    primary.item :search, 'Busca de Aplicativos', apps_path,
                 highlights_on: Proc.new { false }, # nunca oculta o nome
                 unless: Proc.new { !params.has_key? :search },
                 class: 'breadcrumb-mini-item icon-arrow-right-separator-gray_16_18-after',
                 link: { class: 'breadcrumb-mini-link icon-magnifier-lightblue_16_18-before' }
    primary.item :favorites, 'Aplicativos Favoritos',
                 user_favorites_path(current_user || 0),
                 highlights_on: Proc.new { false }, #nunca oculta o nome
                 class: "breadcrumb-mini-link icon-favorite-lightblue_16_18-before",
                 if: Proc.new { controller_name == 'favorites' && can?(:manage, UserAppAssociation) }
  end
end
