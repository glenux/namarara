require 'spec_helper'
require 'mm2ep_depend'

describe Mm2ep::Depend::Lexer do
  let(:lexer) do
    Mm2ep::Depend::Lexer.new
  end

  it 'has to recognize AND operator' do
    line = File
           .read(testfile('success_lexer_and_op.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('AND_OP', lexer.next.type.to_s)
  end

  it 'has to recognize EQ operator' do
    line = File
           .read(testfile('success_lexer_eq_op.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('EQ_OP', lexer.next.type.to_s)
  end

  it 'has to recognize OR operator' do
    line = File
           .read(testfile('success_lexer_or_op.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('OR_OP', lexer.next.type.to_s)
  end

  it 'has to recognize NOT operator' do
    line = File
           .read(testfile('success_lexer_not_op.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('NOT_OP', lexer.next.type.to_s)
  end

  it 'has to recognize false boolean' do
    line = File
           .read(testfile('success_lexer_f_bool.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('F_BOOL', lexer.next.type.to_s)
    assert_equal('F_BOOL', lexer.next.type.to_s)
  end

  it 'has to recognize true boolean' do
    line = File
           .read(testfile('success_lexer_t_bool.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('T_BOOL', lexer.next.type.to_s)
    assert_equal('T_BOOL', lexer.next.type.to_s)
  end

  it 'has to recognize left parenthesis' do
    line = File
           .read(testfile('success_lexer_l_par.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('L_PAR', lexer.next.type.to_s)
  end

  it 'has to recognize right parenthesis' do
    line = File
           .read(testfile('success_lexer_r_par.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('R_PAR', lexer.next.type.to_s)
  end

  it 'has to recognize number' do
    line = File
           .read(testfile('success_lexer_number.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('NUMBER', lexer.next.type.to_s)
  end

  it 'has to recognize string' do
    line = File
           .read(testfile('success_lexer_string.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('STRING', lexer.next.type.to_s)
  end

  it 'has to recognize var' do
    line = File
           .read(testfile('success_lexer_var.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('VAR', lexer.next.type.to_s)
  end

  it 'has to recognize illegal character and replace them with erase them' do
    line = File
           .read(testfile('error_lexer_illegal_character.txt')).delete("\n")
    lexer.input(line.chomp)
    assert_equal('', lexer.next.to_s)
  end
end
