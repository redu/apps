# enconding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'tabs tabs-big'
    primary.item :all_apps, 'Recursos Educacionais Abertos', root_path,
      class: 'tab', alt_class: 'tab tab-active'
    primary.item :favorite_apps,
      "Aplicativos Favoritos #{parentize(@favorite_apps_count || 0)}",
      user_favorites_path(current_user || 0),
      if: Proc.new { can? :manage, UserAppAssociation }, class: 'tab',
      alt_class: 'tab tab-active'
  end
end
