require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class ZenPayroll < OmniAuth::Strategies::OAuth2
      
      option :name, 'zenpayroll'
<<<<<<< HEAD
      option :client_options, { authorize_url: '/oauth/authorize',
                                token_url:     '/oauth/token',
                                site:          'https://zenpayroll.com/' }
                     
      option :token_params, {
        parse:      :json,
        grant_type: 'authorization_code'
      }
=======
      option :client_options, {:authorize_path => '/oauth/authorize',
                               :site => 'https://zenpayroll-demo.com'}
>>>>>>> df6131f... First stage authentication routing works

      option :auth_token_params, {
        param_name: 'access_token',
        mode:       :query
      }

      uid { raw_info['email'] }

      info do
        {
          'email' => raw_info['email']
         }
      end

      extra do
        { :raw_info => raw_info }
      end
      
      # ZenPayroll are strict on redirect_uri.
      # Pass 'origin=...' as parameter to provider url to pass through. 
      def callback_url
        options.authorize_params.callback_url or super
      end
      
      def request_phase
        redirect client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(options.authorize_params))
      end

      def callback_url
        options.authorize_params.callback_url or super
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def build_access_token
        token_params = options.token_params.merge({
            code:          request.params['code'],
            redirect_uri:  callback_url,
            client_id:     client.id,
            client_secret: client.secret
          })
        
        client.get_token(token_params, deep_symbolize(options.auth_token_params))
      end
     end
   end
end

OmniAuth.config.add_camelization 'zenpayroll', 'ZenPayroll'