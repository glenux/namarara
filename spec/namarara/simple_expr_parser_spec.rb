require 'spec_helper'
require 'namarara'

describe Namarara::Parser do
  let(:parser) do
    Namarara::Parser.new(Namarara::Lexer.new)
  end

  it 'has to find var and compute it to expr' do
    line = 'a_girl_has_no_name'
    parser.names = { 'a_girl_has_no_name' => 'true' }
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to find true boolean and compute it to expr' do
    line = 'true'
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to find false boolean and compute it to expr' do
    line = 'false'
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to find parenthesis expr and compute it to expr' do
    line = '( true )'
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to apply not on expr' do
    line = 'NOT true'
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with bool expr and return true' do
    line = 'character = true'
    parser.names = { 'character' => 'true' }
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with bool expr and return false' do
    line = 'character = true'
    parser.names = { 'character' => 'false' }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with number and return true' do
    line = 'nombre = 10'
    parser.names = { 'nombre' => '10' }
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with number and return false' do
    line = 'nombre = 10'
    parser.names = { 'nombre' => '11' }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with string and return true' do
    line = 'a_girl_has_no_name = "Arya Stark"'
    parser.names = { 'a_girl_has_no_name' => 'Arya Stark' }
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with string and return false' do
    line = 'a_girl_has_no_name = "Arya Stark"'
    parser.names = { 'a_girl_has_no_name' => 'Sansa Stark' }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate true OR true and return true' do
    line = 'a_girl_has_no_name OR character'
    parser.names = {
      'a_girl_has_no_name' => 'true',
      'character' => 'true'
    }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate true OR false and return true' do
    line = 'a_girl_has_no_name OR character'
    parser.names = {
      'a_girl_has_no_name' => 'true',
      'character' => 'false'
    }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate false OR true and return true' do
    line = 'a_girl_has_no_name OR character'
    parser.names = {
      'a_girl_has_no_name' => 'false',
      'character' => 'true'
    }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate false OR false and return false' do
    line = 'a_girl_has_no_name OR character'
    parser.names = {
      'a_girl_has_no_name' => 'false',
      'character' => 'false'
    }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate true AND true and return true' do
    line = 'a_girl_has_no_name AND character'
    parser.names = {
      'a_girl_has_no_name' => 'true',
      'character' => 'true'
    }
    token = parser.parse(line)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate true AND false and return false' do
    line = 'a_girl_has_no_name AND character'
    parser.names = {
      'a_girl_has_no_name' => 'true',
      'character' => 'false'
    }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate false AND true and return false' do
    line = 'a_girl_has_no_name AND character'
    parser.names = {
      'a_girl_has_no_name' => 'false',
      'character' => 'true'
    }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate false AND false and return false' do
    line = 'a_girl_has_no_name AND character'
    parser.names = {
      'a_girl_has_no_name' => 'false',
      'character' => 'false'
    }
    token = parser.parse(line)
    assert_equal(false, token.compute)
  end
end
