# enconding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.active_leaf_class = ''
  navigation.autogenerate_item_ids = false
  navigation.items do |primary|
    primary.selected_class = 'tab-active'
    primary.dom_class = 'tabs tabs-big'
    primary.item :all_apps, 'Recursos Educacionais Abertos', root_path,
      highlights_on: Proc.new { controller_name == 'apps' }, class: 'tab',
      link: { class: 'tab-title icon-oer-lightblue_16_18-before' }
    primary.item :favorite_apps,
      "Aplicativos Favoritos #{parentize(@favorite_apps_count || 0)}",
      user_favorites_path(current_user || 0),
      highlights_on: Proc.new { controller_name == 'favorites' },
      if: Proc.new { can? :manage, UserAppAssociation }, class: 'tab',
      link: { class: 'tab-title icon-favorite-lightblue_16_18-before' }
  end
end
