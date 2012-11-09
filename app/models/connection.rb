class Connection < ActiveRecord::Base
  def self.get(url, token)
    logger.debug "(Faraday) Get #{url} com token #{token}"
    conn = connection_setup("Get")
    
    conn.get url
  end

  def self.post(url, data, token)
    logger.debug "(Faraday) Post #{url} com token #{token} e dados: #{data}"
    conn = connection_setup("Post")

    conn.post url, data
  end

  private

  def connection_setup
    conn = Faraday.new(:url => api_url) do | faraday |
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
    conn.headers = { 'Authorization' => "OAuth #{token}", 
                     'Content-type' => 'application/json' }

    conn
  end

  def api_url
    ReduApps::Application.config.api_url
  end
end
