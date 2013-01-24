SimpleNavigation.config_file_path = File.join(Rails.root, 'config', 'navigations')
SimpleNavigation.register_renderer custom_breadcrumbs: CustomBreadcrumbs
SimpleNavigation.register_renderer navigation_tabs: NavigationTabs
SimpleNavigation.register_renderer category_filters: CategoryFilters
