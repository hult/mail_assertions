# MailAssertions

This gem provides two new minitest assertions, `assert_mail` and
`refute_mail` for easily testing whether a specific email has been
sent by your application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mail_assertions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mail_assertions

## Usage

You need to include the module `MailAssertions` in
`ActiveSupport::TestCase`.

Also, you almost certainly want to empty the deliveries list between
every test (otherwise it's hard to know which emails came from this
test).

Therefore, in your `test_helper.rb`:

```ruby
class ActiveSupport::TestCase
  include MailAssertions

  def setup
    ActionMailer::Base.deliveries.clear
  end
end
```

### `assert_mail(conditions, &block)`

Conditions is a hash of attributes on the message object and the
value you're looking for.

```ruby
# Fails unless there was exactly email sent with the subject
# Hello World
assert_mail subject: 'Hello World'
```

You can also specify several conditions, in which case all must apply
for the email to match:

```ruby
# Fails unless there was exactly one email with the subject Hello World
# sent to hello@example.com.
assert_mail subject: 'Hello World', to: ['hello@example.com']
```

Optionally, the values may be regular expressions in which case the
email's value will need to match it

```ruby
# Fails unless there was exactly one email with a subject starting
# with an A
assert_mail subject: /^A/
```

The optional block is invoked with the matching mail

```ruby
assert_mail subject: 'Hello World' do |mail|
  # Further assertions about the email here
end
```

As a convenience, if the block accepts two arguments, the second
will be the HTML body of the email (`mail.html_part.body.to_s`)

```ruby
assert_mail subject: 'Hello World' do |mail, html|
  # Further assertions about the email or its html here
end
```

### `refute_mail(conditions)`

Works similarly to `assert_mail` but fails unless no emails matching
the conditions have been sent.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hult/mail_assertions.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
