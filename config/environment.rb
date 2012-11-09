# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ReduApps::Application.initialize!

# Remove o limite de paginação imposto pelo Sunspot (30 resultados por página)
Sunspot.config.pagination.default_per_page = 9999
