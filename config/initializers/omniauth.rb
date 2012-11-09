Rails.application.config.middleware.use OmniAuth::Builder do
  provider :redu,  ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end
