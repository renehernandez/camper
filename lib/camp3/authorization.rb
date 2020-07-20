# frozen_string_literal: true

module Camp3
  module Authorization

    def authorization_uri
      client = authz_client

      client.authorization_uri type: :web_server
    end

    def authz_client
      Rack::OAuth2::Client.new(
        identifier: Camp3.client_id,
        secret: Camp3.client_secret,
        redirect_uri: Camp3.redirect_uri,
        authorization_endpoint: Camp3.authz_endpoint,
        token_endpoint: Camp3.token_endpoint,
      )
    end

    def authorize!(auth_code)
      client = authz_client
      client.authorization_code = auth_code

      # Passing secrets as query string
      token = client.access_token!(
        client_auth_method: nil,
        client_id: Camp3.client_id,
        client_secret: Camp3.client_secret,
        type: :web_server
        # code: auth_code
      )

      store_tokens(token)

      token
    end

    def update_access_token!(refresh_token = nil)
      Camp3.logger.debug "Update access token using refresh token"
      
      refresh_token = Camp3.refresh_token unless refresh_token
      client = authz_client
      client.refresh_token = refresh_token

      token = client.access_token!(
        client_auth_method: nil,
        client_id: Camp3.client_id,
        client_secret: Camp3.client_secret,
        type: :refresh
      )

      store_tokens(token)

      token
    end

    private

    def store_tokens(token)
      @access_token = token.access_token
      @refresh_token = token.refresh_token
    end
  end
end