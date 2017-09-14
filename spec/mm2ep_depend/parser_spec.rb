require 'spec_helper'
require 'mm2ep_depend'

describe Mm2ep::Depend::Parser do

  it 'has to apply not on expr' do
    line = File.read(testfile('simple_not_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with bool expr and return true' do
    line = File.read(testfile('simple_eq_expr_boolexpr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'true'}
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with bool expr and return false' do
    line = File.read(testfile('simple_eq_expr_boolexpr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'false'}
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with number and return true' do
    line = File.read(testfile('simple_eq_expr_number.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => '10'}
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with number and return false' do
    line = File.read(testfile('simple_eq_expr_number.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => '11'}
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate eq with string and return true' do
    line = File.read(testfile('simple_eq_expr_string.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'test'}
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate eq with string and return false' do
    line = File.read(testfile('simple_eq_expr_string.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'tes'}
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate true OR true and return true' do
    line = File.read(testfile('simple_or_expr_string.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'true',
                  'machin' => 'true'
                 }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate true OR false and return true' do
    line = File.read(testfile('simple_expr_or_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'true',
                  'machin' => 'false'
                 }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate false OR true and return true' do
    line = File.read(testfile('simple_expr_or_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'false',
                  'machin' => 'true'
                 }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate false OR false and return false' do
    line = File.read(testfile('simple_expr_or_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'false',
                  'machin' => 'false'
                 }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate true AND true and return true' do
    line = File.read(testfile('simple_expr_and_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'true',
                  'machin' => 'true'
                 }
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to evaluate true AND false and return false' do
    line = File.read(testfile('simple_expr_and_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'true',
                  'machin' => 'false'
                 }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate false AND true and return false' do
    line = File.read(testfile('simple_expr_and_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'false',
                  'machin' => 'true'
                 }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to evaluate false AND false and return false' do
    line = File.read(testfile('simple_expr_and_expr.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names={'truc_bidule' => 'false',
                  'machin' => 'false'
                 }
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

end
