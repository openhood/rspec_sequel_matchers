[![Build Status](https://travis-ci.org/openhood/rspec_sequel_matchers.svg?branch=master)](https://travis-ci.org/openhood/rspec_sequel_matchers)

# rspec_sequel_matchers

**Starting with version 0.4.0 this gem is only compatible with `RSpec >= 3.x`, if
you want to use it with `RSpec < 3.x` use the 0.3.x versions.**

Some Sequel Matchers for RSpec, using no other gem than rspec and sequel themself. As a consequence, you can use these matchers with Rails, Sinatra or any other framework. It's pretty feature complete.

Matchers assume that you're using the recommanded validation_helpers plugin. All instance validation methods are supported, namely:
* validates_exact_length
* validates_format
* validates_includes
* validates_integer
* validates_length_range
* validates_max_length
* validates_min_length
* validates_not_string
* validates_numeric
* validates_presence
* validates_unique

Each one with all possible options, namely:
* :allow_blank
* :allow_missing
* :allow_nil
* :message

There're also matchers for associations class methods:
* :many_to_many
* :many_to_one
* :one_to_many
* :one_to_one

And there's an additionnal matcher have_column to check columns existance and their type, see example usage bellow.

RspecSequel::Matchers has an extensive test suite and will give you as much explanation as possible in failure messages such as expected column type versus column type found in database.

## Install

```sh
gem install rspec_sequel_matchers
```

or with `Bundler`, put in you `Gemfile`:

```ruby
gem "rspec_sequel_matchers", group: :test
```

## Config

In spec_helper.rb

```ruby
RSpec.configure do |config|
  config.include RspecSequel::Matchers
  # ... other config ...
end
```

## Example usage

```ruby
describe Item do
  it{ is_expected.to have_column :name, :type => String }
  it{ is_expected.not_to have_column :wrong_name }
  it{ is_expected.to validate_presence :name, :allow_nil => true }
end
```

## Copyright

Copyright (c) 2009-2014 Jonathan Tron - Joseph Halter. See LICENSE for details.
