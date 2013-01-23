class NavigationTabs < SimpleNavigation::Renderer::Base

  def render(item_container)
    list_content = item_container.items.inject([]) do |list, item|
      switch_class(item)
      li_options = item.html_options.reject {|k, v| k == :link}
      li_options = li_options.merge(class: switch_class(item))
      li_options.delete(:alt_class)
      li_options
      item.html_options =  item.html_options.merge(
        link: { class: "tab-title icon-oer-lightblue_16_18-before" })
      li_content = tag_for(item)
      if include_sub_navigation?(item)
        li_content << render_sub_navigation_for(item)
      end
      list << content_tag(:li, li_content, li_options)
    end.join
    if skip_if_empty? && item_container.empty?
      ''
    else
      content_tag((options[:ordered] ? :ol : :ul), list_content, {:id => item_container.dom_id, :class => item_container.dom_class})
    end
  end

  protected

  # Utiliza a classe alt_class caso o elemento da aba esteja ativo
  def switch_class(item)
    if !item.active_leaf_class
      item.html_options[:class]
    else
      item.html_options[:alt_class]
    end
  end
end
