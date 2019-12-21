require 'spec_helper'
require 'namarara'

describe Namarara::Lexer do
  let(:lexer) do
    Namarara::Lexer.new
  end

  it 'has to recognize AND operator' do
    line = 'AND'
    lexer.input(line)
    assert_equal('AND_OP', lexer.next.type.to_s)
  end

  it 'has to recognize EQ operator' do
    line = '='
    lexer.input(line)
    assert_equal('EQ_OP', lexer.next.type.to_s)
  end

  it 'has to recognize OR operator' do
    line = 'OR'
    lexer.input(line)
    assert_equal('OR_OP', lexer.next.type.to_s)
  end

  it 'has to recognize NOT operator' do
    line = 'NOT'
    lexer.input(line)
    assert_equal('NOT_OP', lexer.next.type.to_s)
  end

  it 'has to recognize false boolean' do
    line = 'false False'
    lexer.input(line)
    assert_equal('F_BOOL', lexer.next.type.to_s)
    assert_equal('F_BOOL', lexer.next.type.to_s)
  end

  it 'has to recognize true boolean' do
    line = 'true True'
    lexer.input(line)
    assert_equal('T_BOOL', lexer.next.type.to_s)
    assert_equal('T_BOOL', lexer.next.type.to_s)
  end

  it 'has to recognize left parenthesis' do
    line = '('
    lexer.input(line)
    assert_equal('L_PAR', lexer.next.type.to_s)
  end

  it 'has to recognize right parenthesis' do
    line = ')'
    lexer.input(line)
    assert_equal('R_PAR', lexer.next.type.to_s)
  end

  it 'has to recognize number' do
    line = '7'
    lexer.input(line)
    assert_equal('NUMBER', lexer.next.type.to_s)
  end

  it 'has to recognize string' do
    line = %("Arya Stark")
    lexer.input(line.chomp)
    assert_equal('STRING', lexer.next.type.to_s)
  end

  it 'has to recognize var' do
    line = 'character'
    lexer.input(line)
    assert_equal('VAR', lexer.next.type.to_s)
  end

  it 'has to recognize illegal character and replace them with erase them' do
    line = '?'
    lexer.input(line)
    assert_equal('', lexer.next.to_s)
  end
end
