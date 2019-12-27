
require 'namarara'

# Initialize Namarara
namarara = Namarara::Parser.new(Namarara::Lexer.new)

# Build the binary expression tree (aka BET)
exp_tree = namarara.parse('this AND (that OR other) AND something_else')
puts p

# Prepare variables 
exp_tree.names = {
  this: 'true',
  that: 'false',
  other: 'false',
  something_else: 'true'
}

# Compute tree with variables
result = exp_tree.compute
puts "#{result} == "
