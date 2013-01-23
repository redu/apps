class FiltersMenu < SimpleNavigation::Renderer::Base

  def render(item_container)
    content = a_tags(item_container).join(join_with)
    content_tag(:ul, content, {id: "apps-portal-breadcrumb",
                               class: "breadcrumb-mini"})
  end

  protected

  def a_tags(item_container)
    item_container.items.inject([]) do |list, item|
      if item.selected?
        list << anchor_tag(item)
        if include_sub_navigation?(item)
          list.concat a_tags(item.sub_navigation)
        end
      end
      list
    end
  end

  # Cria o elemento âncora envolto por um li para cada elemento do breadcrumb
  def anchor_tag(item)
    if item.name == '' # Descarta elementos vazios (zombies do simple-navigation)
      nil
    else
      li_content = content_tag(:a, item.name, { href: item.url,
                                                class: switch_class(item) })

      content_tag(:li, li_content,
                  class: "breadcrumb-mini-item icon-arrow-right-" + \
                    "separator-gray_16_18-after")
    end
  end

  def join_with
    @join_with ||= options[:join_with] || " "
  end

  # Utiliza a classe alt_class caso o elemento do breadcrumb não esteja ativo
  def switch_class(item)
    if !item.active_leaf_class
      item.html_options[:alt_class]
    else
      item.html_options[:class]
    end
  end
end
