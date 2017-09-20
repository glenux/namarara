require 'spec_helper'
require 'mm2ep_depend'

describe Mm2ep::Depend::Parser do
  let(:parser) do
    Mm2ep::Depend::Parser.new(
      Mm2ep::Depend::Lexer.new
    )
  end

  it 'has to report var which is not defined' do
    line = File
           .read(testfile('success_simple_eq_expr_boolexpr.txt')).delete("\n")
    parser.names = {}
    token = parser.parse(line.chomp)
    errors = token.errors.select { |el| el.is_a? Mm2ep::Depend::VarNotDefined }
    errors.size.must_equal 1
    errors[0].var.must_equal 'character'
  end

  it 'has to report vars which are not defined' do
    line = File.read(testfile('success_simple_expr_or_expr.txt')).delete("\n")
    parser.names = {}
    token = parser.parse(line.chomp)
    errors = token.errors.select { |el| el.is_a? Mm2ep::Depend::VarNotDefined }
    errors.size.must_equal 2
    errors[0].var.must_equal 'a_girl_has_no_name'
    errors[1].var.must_equal 'character'
  end

  it 'has to report invalid_grammar' do
    line = File
           .read(testfile('error_grammar_partially_invalid.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => true, 'character' => 'Arya Stark' }
    token = parser.parse(line.chomp)
    parser.check_grammar line, token
    token.errors.select do |elem|
      elem.is_a? Mm2ep::Depend::InvalidGrammar
    end.size.must_equal 1
  end

  it 'has to be nil when grammar is completely invalid' do
    line = File
           .read(testfile('error_grammar_completely_invalid.txt')).delete("\n")
    parser.names = {}
    token = parser.parse(line.chomp)
    parser.check_grammar line, token
    assert_nil token
  end
end
