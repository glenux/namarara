# frozen_string_literal: true

require 'namarara/version'

module Namarara; end

require 'rly'

require 'namarara/lexer'
require 'namarara/parser'
require 'namarara/eval_error'
require 'namarara/errors/var_not_defined'
require 'namarara/errors/invalid_grammar'

module Namarara
  def self.parse_string(line, vars, debug = false)
    parser = Parser.new(Lexer.new)
    parser.names = vars
    parser_bet = parser.parse(line.chomp, debug)
    parser.check_grammar line, parser_bet

    {
      expr: line,
      tree: parser_bet.to_s,
      errors: parser_bet&.errors&.map { |e| e.message },
      result: parser_bet&.compute
    }
  end
end
