class Connection
  def initialize(token, opts = {})
    @token = token
    @config = opts.merge(url: ReduApps::Application.config.api_url)
  end

  def get(url)
    connection.get url
  end

  def post(url, data)
    connection.post url, data
  end

  private

  def connection
    @conn ||= Faraday.new(url: @config[:url]) do |faraday|
      faraday.request :url_encoded
      faraday.adapter :patron
      faraday.headers = { 'Authorization' => "OAuth #{@token}",
                          'Content-type' => 'application/json' }
    end

    @conn
  end
end
