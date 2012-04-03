require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class AlphaLogin < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "alphalogin"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "http://0.0.0.0:4000", :token_url => "/oauth/access_token"}

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/profile').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer
  provider :github, "a5d68af22af0f5953441", "c4d7eec03de01f292cce4b49001331a235d0eec3"
  provider :alpha_login, "ZopeVBlfYMAASOpM255GbGYZthhuh472nnDtSNth", "Bk4XMhgMxHYqlQnzRwvbhkPlFbdxjHsohYdDoAtl"
end
