Untied::Consumer.configure do |config|
  config.logger = Rails.logger
  config.observers = [UntiedGeneralObserver]
end