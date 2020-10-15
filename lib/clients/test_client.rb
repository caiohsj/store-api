require "rack/test"

class TestClient
  include Rack::Test::Methods

  def login(endpoint, body = {})
    response = make_post(endpoint, body)
    set_auth_headers(response)
    response
  end

  def create_user(endpoint, body = {})
    response = make_post(endpoint, body)
    set_auth_headers(response)
    response
  end

  def make_get(endpoint, query = {})
    response = handle_response(get(endpoint,
                                  query,
                                  headers))
    response
  end

  def make_post(endpoint, body = {})
    response = handle_response(post(endpoint,
                                    body,
                                    headers))
    response
  end

  def make_put(endpoint, body = nil)
    response = handle_response(put(endpoint,
                                   body,
                                   headers))
    response
  end

  def make_delete(endpoint)
    response = handle_response(delete(endpoint,
                                      {},
                                      headers))
    response
  end

  def app
    Rails.application
  end

    def headers
    {
      'HTTP_USER_TOKEN' => @token,
      'HTTP_USER_EMAIL' => @email
    }
  end

  private

  def handle_response(response)
    log("Response with status code #{response.status}")
    if response.body.present?
      json_response = JSON.parse response.body
      parsed_response = json_response.deep_symbolize_keys
    else
      {}
    end
  end

  def log(message)
    Rails.logger.info(message)
  end

  def set_auth_headers(response)
    @token = response[:token]
    @email = response[:email]
  end

end
