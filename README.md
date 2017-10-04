# CivilNumber

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/civil_number`. To experiment with that code, run `bin/console` for an interactive prompt.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'civil_number'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install civil_number

## Usage
The country_code should always be a ISO 3166-1 alpha-2 (http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2).
```ruby
# Options:
#   :number => Civil number.
#   :country_code => Some fallback code (eg. 'nl').
#   :birth_date => Birth date (eg. 'yyyy-mm-dd').
#   :gender => Gender (eg. 'famale').
```
Validations
```ruby
CivilNumber::Validator.new({number:'Some number', country_code:'nl'}).valid? # => true

CivilNumber::Validator.new({number:'Some number', country_code:'nl', birth_date: 'yyyy-mm-dd'}).valid? # => true

CivilNumber::Validator.new({number:'Some number', country_code:'nl'}) # => #<CivilNumber::Validator:0x000000021e2420 @civil_number="Some number", @country_code="NL", @birth_date=birth_date from civil number information, @gender=gender from civil number information>

civil_number = CivilNumber::Validator.new({number:'Some number', country_code:'nl'})
civil_number.valid? # => false
civil_number.error # => "birth date 1933-09-25 dont match 1933-09-24"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TankiaiTaskuota/civil_number. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CivilNumber project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/TankiaiTaskuota/civil_number/blob/master/CODE_OF_CONDUCT.md).