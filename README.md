[![Code Climate](https://codeclimate.com/github/ContinuityControl/fdic/badges/gpa.svg)](https://codeclimate.com/github/ContinuityControl/fdic)
[![Test Coverage](https://codeclimate.com/github/ContinuityControl/fdic/badges/coverage.svg)](https://codeclimate.com/github/ContinuityControl/fdic/coverage)
[![Build Status](https://travis-ci.org/ContinuityControl/fdic.svg?branch=master)](https://travis-ci.org/ContinuityControl/fdic)

# FDIC

The FDIC [lets you find information on FDIC-insured banking
institutions](https://research.fdic.gov/bankfind/index.html). Their site uses
[a JSON
API](http://www.programmableweb.com/news/fdic-bank-data-api-available-official-announcement-pending/2015/02/06)
to look up financial information, branch information, etc.

This gem is a ruby client to that API. It's totally unaffiliated with the FDIC.
It's open source, so anyone can use it, and anyone can help maintain it. At
this point, it's maintained by [the
developers](http://engineering.continuity.net/) at
[Continuity](http://continuity.net).

If you need help understanding the data returned by that API, and this gem, it
can help to look at [the FDIC's BankFind glossary of
terms](https://research.fdic.gov/bankfind/glossary.html).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fdic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fdic

## Usage

Currently all of our features are namespaced under the `FDIC::BankFind` module

The FDIC API lets you find an Institution if you have its FDIC Certificate Number:

```ruby
institution = FDIC::BankFind.find_institution(26588)  #=> FDIC::BankFind::Institution
```

If your certificate number is incorrect, this will raise an exception:

```ruby
institution = FDIC::BankFind.find_institution(26588)  #=> FDIC::BankFind::Institution
# raises FDIC::Exceptions::RecordNotFound
```

If you don't have the certificate number, you can search for a Bank by name, and get back all matching Banks:

```ruby
banks = FDIC::BankFind.find_bank('Dedicated Community Bank')  #=> [FDIC::BankFind::Bank, FDIC::BankFind::Bank, ...]
```

Once you have a Bank, you can get its Institution, which has much more data available:

```ruby
institution = banks.first.find_institution!  # Bang, because it's another network request
```

The API also exposes information about an Institution's branches, and its history. You can query both of these on the FDIC::BankFind module directly, or on the Institution:

```ruby
institution.find_branches!  #=> [FDIC::BankFind::Branch, FDIC::BankFind::Branch, ...]
FDIC::BankFind.find_branches(25688)   #=> [FDIC::BankFind::Branch, FDIC::BankFind::Branch, ...]

institution.find_history_events!                              #=> [FDIC::BankFind::HistoryEvent, ...]
FDIC::BankFind.find_history_events('Dedicated Community Bank', 26588)   #=> [FDIC::BankFind::HistoryEvent, ...]
```

Since a `Bank` knows its certificate number, it can look up its branch and history information, too.

```ruby
# These work just like they do on Institutions:
bank.find_branches!
bank.find_history_events!
```

There are more fields exposed in the Institution API then what we've exposed. Where the field names are obscure or acronym-y, we'd like to clarify them; since we're pre-1.0, if we haven't looked up a field's meaning quite yet, we're holding off. (You can still get all the fields via `#attributes`.)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ContinuityControl/fdic.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
