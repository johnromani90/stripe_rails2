# Stripe Rails

gem to quickly hook up a stripe plan with custom subscriptions

“`ruby gem 'stripe_rails' “`

And then execute: “`bash $ bundle “`

Or install it yourself as: “`bash $ gem install stripe_rails “`

Then run : “`bash rails g stripe_rails:install “`

And

“` rake stripe_rails:install:migrations “`

Add the following stripe keys to your environment or a .env file in your application root: “` export STRIPE_RAILS_STRIPE_SECRET_KEY=your_key export STRIPE_RAILS_STRIPE_PUBLISHABLE_KEY=your_key “`

## Contributing Contribution directions go here.

## License The gem is available as open source under the terms of the [MIT License](opensource.org/licenses/MIT).