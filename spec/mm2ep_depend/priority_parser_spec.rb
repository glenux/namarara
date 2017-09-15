require 'spec_helper'
require 'mm2ep_depend'

describe Mm2ep::Depend::Parser do
  it 'has to do not before or' do
    line = File.read(testfile('priority_not_or.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to do not before and' do
    line = File.read(testfile('priority_not_and.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end

  it 'has to do and before or' do
    line = File.read(testfile('priority_or_and.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  it 'has to do and before or operators' do
    line = File.read(testfile('priority_or_and_or.txt')).delete("\n")
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    token = parser.parse(line.chomp)
    assert_equal(true, token.compute)
  end
end
