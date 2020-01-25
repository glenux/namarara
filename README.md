# Namarara

![Build](https://github.com/glenux/namarara/workflows/build/badge.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/namarara.svg)](https://rubygems.org/gems/namarara)
[![GitHub license](https://img.shields.io/github/license/glenux/namarara.svg)](https://github.com/glenux/namarara/blob/master/LICENSE)
[![Donate on patreon](https://img.shields.io/badge/patreon-donate-green.svg)](https://patreon.com/glenux)

Namarara is a library that can parses boolean expressions, builds an [binary
expression tree](https://en.wikipedia.org/wiki/Binary_expression_tree) and
evalutes a result given a set of values associated to the variables used within
the boolean expression.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'namarara'
```

And then execute:

```shell-session
$ bundle
```

Or install it yourself as:

```shell-session
$ gem install namarara
```

## Usage

### Evaluate a single expression

```ruby
require 'namarara'

# Initialize Namarara
namarara = Namarara::Parser.new(Namarara::Lexer.new)

# Prepare variables 
namarara.names = {
  this: 'true',
  that: 'false',
  other: 'false',
  something_else: 'true'
}

# Build a binary expression tree (aka BET) from string
# and inject values
exp_tree = namarara.parse('this AND (that OR other) AND something_else')

# Compute tree with variables
result = exp_tree.compute
puts result # = false
```

### Evaluating a set of rules

```ruby
require 'namarara'

# Initialize Namarara
namarara = Namarara::Parser.new(Namarara::Lexer.new)

# A set of rules i want to check 
# (in this example we are looking for sensitive personnal data)
rules = {
    vulnerable_person: 'is_adult AND is_subordinate',
    has_constraints: 'is_adult AND has_children',
    is_child: 'NOT is_adult'
    # ...
}

# A set of values i want to inject (values must be expressed as strings)
namarara.names = {
    "is_adult" => 'false', 
    "is_subordinate" => 'true',
    "has_children" => 'true'
}

results = rules.map { |rule, expr| [rule, namarara.parse(expr).compute] }

if results.select{ |rule, value| value }.empty?
    puts "Perfect! Nothing to say ;-)"
else
    puts "Warning: you are collectif sensitive personnal data !"
    results.each do |rule, value|
      puts "#{value ? '>>':'  '} #{rule}: #{value}" 
    end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. 

Then, run `rake test` to run the tests. 

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/glenux/namarara


## License and copyright

[Namarara](https://github.com/glenux/namarara) is an open source project under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Original author : [Brendon Torre](https://www.linkedin.com/in/brendon-torre-b128a0168)

Current developer & maintainer : Glenn Y. Rolland ([@glenux](https://twitter.com/glenux))


## Sponsors and funding

[Namarara](https://github.com/glenux/namarara) is an independent project whose development and maintenance is made possible thanks to the support of its patrons.

If you wish to join them and support the work of its author, just participate with this link :

__&gt;&gt;&gt;&nbsp;[Become a patron or sponsor on Patreon](https://www.patreon.com/glenux)&nbsp;&lt;&lt;&lt;__

