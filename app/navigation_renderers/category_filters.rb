class CategoryFilters < SimpleNavigation::Renderer::Base

  def render(item_container)
    items = item_container.items.inject([]) do |list, item|
      list << tag_for(item)
    end.join
    if skip_if_empty? && item_container.empty?
      ''
    else
      content_tag(:div, items, {:id => item_container.dom_id, :class => item_container.dom_class})
    end
  end
end
