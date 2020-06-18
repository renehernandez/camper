# frozen_string_literal: true

module Camp3
  module Authorization

    def authz_endpoint
      client = authz_client

      client.authorization_uri type: :web_server
    end

    def authz_client
      Rack::OAuth2::Client.new(
        identifier: Configuration.client_id,
        secret: Configuraton.client_secret,
        redirect_uri: Configuration.redirect_uri,
        authorization_endpoint: Configuration.auth_endpoint,
        token_endpoint: Configuration.token_endpoint,
      )
    end

    def authorize!(auth_code)
      client = authz_client
      client.authorization_code = auth_code

      # Passing secrets as query string
      token = client.access_token!(
        # client_auth_method: nil,
        # client_id: Configuration.client_id,
        # client_secret: Configuration.client_secret,
        type: :web_server
        # code: auth_code
      )

      store_tokens(token)

      token
    end

    def update_access_token!
      client = authz_client

      client.refresh_token = refresh_token

      token = client.access_token!(
        type: :web_server
      )

      store_tokens(token)

      token
    end

    private

    def store_tokens(token)
      self.access_token = token.access_token
      self.refresh_token = token.refresh_token
    end
  end
end