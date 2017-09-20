require 'spec_helper'
require 'mm2ep_depend'

describe Mm2ep::Depend::Parser do
  let(:parser) do
    Mm2ep::Depend::Parser.new(
      Mm2ep::Depend::Lexer.new
    )
  end

  it 'has to apply not on expr' do
    line = File
           .read(testfile('success_simple_not_expr.txt')).delete("\n")
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with bool expr and return true' do
    line = File
           .read(testfile('success_simple_eq_expr_boolexpr.txt')).delete("\n")
    parser.names = { 'character' => 'true' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with bool expr and return false' do
    line = File
           .read(testfile('success_simple_eq_expr_boolexpr.txt')).delete("\n")
    parser.names = { 'character' => 'false' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with number and return true' do
    line = File
           .read(testfile('success_simple_eq_expr_number.txt')).delete("\n")
    parser.names = { 'nombre' => '10' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with number and return false' do
    line = File
           .read(testfile('success_simple_eq_expr_number.txt')).delete("\n")
    parser.names = { 'nombre' => '11' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with string and return true' do
    line = File
           .read(testfile('success_simple_eq_expr_string.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'Arya Stark' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with string and return false' do
    line = File
           .read(testfile('success_simple_eq_expr_string.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'Sansa Stark' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate true OR true and return true' do
    line = File
           .read(testfile('success_simple_expr_or_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'true',
                     'character' => 'true' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate true OR false and return true' do
    line = File
           .read(testfile('success_simple_expr_or_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'true',
                     'character' => 'false' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate false OR true and return true' do
    line = File
           .read(testfile('success_simple_expr_or_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'false',
                     'character' => 'true' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate false OR false and return false' do
    line = File
           .read(testfile('success_simple_expr_or_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'false',
                     'character' => 'false' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate true AND true and return true' do
    line = File
           .read(testfile('success_simple_expr_and_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'true',
                     'character' => 'true' }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate true AND false and return false' do
    line = File
           .read(testfile('success_simple_expr_and_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'true',
                     'character' => 'false' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate false AND true and return false' do
    line = File
           .read(testfile('success_simple_expr_and_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'false',
                     'character' => 'true' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate false AND false and return false' do
    line = File
           .read(testfile('success_simple_expr_and_expr.txt')).delete("\n")
    parser.names = { 'a_girl_has_no_name' => 'false',
                     'character' => 'false' }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end
end
