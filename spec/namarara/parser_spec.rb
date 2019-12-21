# frozen_string_literal: true

require 'spec_helper'
require 'namarara'

describe Namarara::Parser do
  let(:parser) do
    Namarara::Parser.new(Namarara::Lexer.new)
  end

  it 'has to report var which is not defined' do
    line = 'character = true'
    parser.names = {}
    token = parser.parse(line)
    errors = token.errors.select do |el|
      el.is_a? Namarara::Errors::VarNotDefined
    end
    _(errors.size).must_equal 1
    _(errors[0].var).must_equal 'character'
  end

  it 'has to report vars which are not defined' do
    line = 'a_girl_has_no_name AND character'
    parser.names = {}
    token = parser.parse(line)
    errors = token.errors.select do |el|
      el.is_a? Namarara::Errors::VarNotDefined
    end
    _(errors.size).must_equal 2
    _(errors[0].var).must_equal 'a_girl_has_no_name'
    _(errors[1].var).must_equal 'character'
  end

  it 'has to report invalid_grammar' do
    line = '( a_girl_has_no_name = true ) ' \
           'ANDAND ( character = "Arya Stark" ) OR false AND true'
    parser.names = { 'a_girl_has_no_name' => true, 'character' => 'Arya Stark' }
    token = parser.parse(line)
    parser.check_grammar line, token
    _(token.errors.select do |elem|
      elem.is_a? Namarara::Errors::InvalidGrammar
    end.size).must_equal 1
  end

  it 'has to be nil when grammar is completely invalid' do
    line = 'false / "Arya"'
    parser.names = {}
    token = parser.parse(line)
    parser.check_grammar line, token
    assert_nil token
  end
end
