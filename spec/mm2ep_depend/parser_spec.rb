require 'spec_helper'
require 'mm2ep_depend'

describe Mm2ep::Depend::Parser do

  it 'has to evaluate expression and give right answer' do
    line = File.read(testfile('test2.txt')).gsub(/\n/,'')
    parser = Mm2ep::Depend::Parser.new(Mm2ep::Depend::Lexer.new)
    parser.names({'truc_bidule' => 'true',
                  'machin' => 'true',
                  'truc' => 'false'
                  })
    token = parser.parse(line.chomp)
    assert_equal(false, token.compute)
  end

  # it 'has to be true' do
  #
  # end
end
