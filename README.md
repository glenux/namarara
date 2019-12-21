# Namarara

Namarara is a library that parses boolean expressions, builds an [binary
expression tree](https://en.wikipedia.org/wiki/Binary_expression_tree). 

Namare can also evalutes a result from a set of values corresponding the
variables used within the boolean expression.


2. binary expression 
and computes a boolean result from this AST.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mm2ep_depend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mm2ep_depend

## Usage

### Evaluate a single expression

```
# Initialize Namarara
namarara = Namarara.new

# Build the binary expression tree (BET)
namarara_bet = namarara.parse('this AND (that OR other) AND something_else')

# Prepare variables 
variables = {
  this: true,
  that: false,
  other: false,
  something_else: true
}

# Compute tree with variables
result = namarara_bet.compute(variables)
```

### Evaluating a set of rules

```ruby
# Initialize Namarara
namarara = Namarara::Parser.new(Namarara::Lexer.new)

# A set of rules i want to check
rules = [
    {name: 'vulnetable_person', expr: 'is_adult AND is_subordinate'},
    {name: 'has_constraints', expr: 'is_adult AND has_children' },
    {name: 'is_child', expr: 'NOT is_adult'}
    # ...
]

# A set of values i want to inject (values can come from HTTP or from database
# as long as they are expressed as strings)
namarara.names = {
    "is_adult" => 'false', 
    "is_subordinate" => 'true',
    "has_children" => 'true'
}

rules.map do |rule|
    namarara_bet = namarara.parse(rule)
    result = namarara_bet.compute
    if result then
        warnings << "Rule #{rule} is true"
    end
end

if not warnings.empty?
puts "Attention: vous collectez des DCP de personnes vulnerables"
puts warnings.join("\n")
else
puts "Rien à dire :-)"
end

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mm2ep_depend.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
