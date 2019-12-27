
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

