# FDIC

The FDIC [lets you find information on FDIC-insured banking
institutions](https://research.fdic.gov/bankfind/index.html). Their site uses
[a JSON
API](http://www.programmableweb.com/news/fdic-bank-data-api-available-official-announcement-pending/2015/02/06)
to look up financial information, branch information, etc.

This gem is a ruby client to that API. It's totally unaffiliated with the FDIC.
It's open source, so anyone can use it, and anyone can help maintain it. At
this point, it's maintained by the developers at
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

You can look up a Bank by its name, and find all matching Banks:

```
# Returns an Array:
FDIC.find_bank('Dedicated Community Bank')  #=> [FDIC::Bank, FDIC::Bank, ...]
```

You can look up an Institution by its FDIC Certificate number:

```
# Returns only one:
FDIC.find_institution(26588)  #=> FDIC::Institution
```

You can look up a Bank's branches by its FDIC Certificate number:

```
# Returns an Array:
FDIC.find_branches(25688)  #=> [FDIC::Branch, FDIC::Branch, ...]
```

You can look up a Bank's history by its name and FDIC Certificate number:

```
# Returns an Array:
FDIC.find_history_events('Dedicated Community Bank', 26588)  #=> [FDIC::HistoryEvent, ...]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ContinuityControl/fdic.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

