# Gpsoauth

A Ruby client library for Google Play Services OAuth

A port of the Python library [gpsoauth](https://github.com/simon-weber/gpsoauth) by [Simon Weber](https://github.com/simon-weber)

Android Play Service OAuth flow: [Sbktech](https://sbktech.blogspot.com/2014/01/inside-android-play-services-magic.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gpsoauth'
```

And then execute:

    $ bundle

    Or install it yourself as:

        $ gem install gpsoauth

## Usage

Instantiate a Gpsoauth connection:

    g = Gpsoauth::Connection.new

Perform 'master login'. This requires an Android ID:

    response = g.master_login('your-email@gmail.com', 'your-password', 'android id')

Use the response's token to perform the OAuth:

    oauth_response = g.oauth(... // @TODO

Access response Auth token via:

    oauth_response["Auth"]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bryanmytko/gpsoauth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

