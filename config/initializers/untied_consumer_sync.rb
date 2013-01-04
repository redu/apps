Untied::Consumer::Sync.configure do |config|
  config.model_data = "#{Rails.root}/config/model_data.yml"
  config.service_name = 'core'
end
