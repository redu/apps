class Connection
  def initialize(token, opts = {})
    @token = token
    @config = opts.merge(url: ReduApps::Application.config.api_url)
  end

  def get(url)
    connection.get url
  end

  def post(url, data, &block)
    response = connection.post(url, data)
    handle_response(response, &block)
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

  def handle_response(response, &block)
    case response.status
    when 201
      entity = JSON.parse response.body
      yield(response, entity) if block_given?
    when 401 # Permissão negada
      raise ActiveResource::UnauthorizedAccess.new(response)
    when 422 # Payload mal formatado
      raise ActiveResource::BadRequest.new(response)
    else
      raise "Unknown status code #{response.status}"
    end
  end
end
