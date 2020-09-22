# frozen_string_literal: true

module Camper
  module Authorization

    def authorization_uri
      client = authz_client

      client.authorization_uri type: :web_server
    end

    def authz_client
      Rack::OAuth2::Client.new(
        identifier: @config.client_id,
        secret: @config.client_secret,
        redirect_uri: @config.redirect_uri,
        authorization_endpoint: @config.authz_endpoint,
        token_endpoint: @config.token_endpoint,
      )
    end

    def authorize!(auth_code)
      client = authz_client
      client.authorization_code = auth_code

      # Passing secrets as query string
      token = client.access_token!(
        client_auth_method: nil,
        client_id: @config.client_id,
        client_secret: @config.client_secret,
        type: :web_server
      )

      store_tokens(token)

      token
    end

    def update_access_token!
      logger.debug "Update access token using refresh token"
      
      client = authz_client
      client.refresh_token = @config.refresh_token

      token = client.access_token!(
        client_auth_method: nil,
        client_id: @config.client_id,
        client_secret: @config.client_secret,
        type: :refresh
      )

      store_tokens(token)

      token
    end

    private

    def store_tokens(token)
      @config.access_token = token.access_token
      @config.refresh_token = token.refresh_token
    end
  end
end