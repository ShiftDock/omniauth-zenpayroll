# OmniAuth ZenPayroll

This gem contains the ZenPayroll strategy for OmniAuth.

ZenPayroll implements a standard [OAuth 2.0](http://en.wikipedia.org/wiki/OAuth#OAuth_2.0) authentication process, issuing 
a short term (~10 minute ttl) authentication token that is then used to retrieve a longer-term (~2 hour ttl) access token 
and single-use refresh token.

For more detailed information see the [ZenPayroll Authentication Example](http://docs.zenpayroll.com/v1/examples/authentication/)
in the API docs.

## Before You Begin

You should have already installed OmniAuth in your app; if not, read the [OmniAuth README](https://github.com/intridea/omniauth) 
to get started. Also, Ryan Bates has made a number of excellent [Railscasts](http://railscasts.com/episodes/235-devise-and-omniauth-revised)
on getting started with OmniAuth and Devise.

You'll need to create an application with ZenPayroll first. Take note of your Client ID, Client Secret and Redirect URI,
your application will use these to authenticate against the ZenPayroll API.

## Using This Strategy

Add the gem to your Gemfile:

```ruby
gem 'omniauth-zenpayroll'
```

If you need to use the latest HEAD version, you can do so with:

```ruby
gem 'omniauth-zenpayroll', :github => 'shiftdock/omniauth-zenpayroll'
```

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :zenpayroll, "CLIENT_ID", "CLIENT_SECRET"
end
```

Replace `CLIENT_ID` and `CLIENT_SECRET` with the appropriate values you obtained from ZenPayroll earlier.

If you need to override the Redirect URI (i.e. if yours deviates from the default) you can do so by setting it as the
`callback_url` in an `authorize_params` options hash. 

```ruby
Rails.application.config.middleware.user OmniAuth:Builder do
  provider :zenpayroll, "CLIENT_ID", "CLIENT_SECRET", :authorize_params => {:callback_url => '/my/app/callback/url'}
end
```

#### UID Gotcha

As the ZenPayroll API doesn't expose a unique ID for the user being authenticated we have to use their email address 
instead. ZenPayroll ensure that it will be unique. To remain consistent with other OmniAuth strategies the email address
is returned as both the `uid` and as `email` in the `info` hash.

## Authentication Hash

An example auth hash available in `request.env['omniauth.auth']`:
```ruby
{
  :provider => "zenpayroll",
  :uid => "auth_user@zenpayroll.x",
  :info => {
    :email => "auth_user@zenpayroll.x"
  },
  :credentials => {
    :token         => "a1b2c3d4...", # The OAuth 2.0 access token
    :refresh_token => "abcdef1234",
    :expires       => true,
    :expires_at    => 456102000
  },
  :extra => {
    :email => "auth_user@zenpayroll.x",
    :permissions => {
      :payroll_admin => {
        :company_ids => [123456789]
      }
    }
  }
}
```

## Tests

Although the strategy is currently in production use at [ShiftDock](https://shiftdock.com), the version is <1.0.0 until the project
includes robust tests.

## Credits

Built with example from the awesome [omniauth-twitter](https://github.com/arunagw/omniauth-twitter) gem by Arun Agrawal and 
[omniauth-facebook](https://github.com/mkdynamic/omniauth-facebook) gem by Mark Dodwell.


## License

Copyright (c) 2013 by John M. Hope

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
