# frozen_string_literal: true

require 'spec_helper'
require 'namarara'

describe Namarara::Parser do
  let(:parser) do
    Namarara::Parser.new(Namarara::Lexer.new)
  end

  it 'has to do not before or' do
    line = 'NOT true OR NOT true'
    parser.names = {}
    token = parser.parse(line)
    assert_equal('( NOT ( bool:true ) ) OR ( NOT ( bool:true ) )', token.to_s)
  end

  it 'has to do not before and' do
    line = 'NOT false AND NOT false'
    parser.names = {}
    token = parser.parse(line)
    assert_equal(
      '( NOT ( bool:false ) ) AND ( NOT ( bool:false ) )',
      token.to_s
    )
  end

  it 'has to do and before or' do
    line = 'false OR true AND false'
    parser.names = {}
    token = parser.parse(line)
    assert_equal(
      '( bool:false ) OR ( ( bool:true ) AND ( bool:false ) )',
      token.to_s
    )
  end

  it 'has to do and before or operators' do
    line = 'false OR false AND true OR true'
    parser.names = {}
    token = parser.parse(line)
    assert_equal(
      '( ( bool:false ) OR ( ( bool:false ) '\
      'AND ( bool:true ) ) ) OR ( bool:true )',
      token.to_s
    )
  end
end
