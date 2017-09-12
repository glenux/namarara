module Mm2ep
  module Depend
    class Lexer < Rly::Lex

      ignore "\t\n "

      # token :SPACE, /\s+/
      token :L_PAR, /\(/
      token :R_PAR, /\)/
      token :NUMBER, /[0-9]+(\.[0-9]+)?/
      token :STRING, /"([^"]*)"/ do |s|
        s.value.gsub!(/"(.*)"/,'\1')
        s
      end

      token :EQ_OP, /\=/
      token :T_BOOL, /true/i
      token :F_BOOL, /false/i
      token :VAR, /[a-z][a-zA-Z0-9_]+/
      token :AND_OP, /AND/
      token :OR_OP, /OR/
      token :NOT_OP, /NOT/

      on_error do |t|
        puts "Illegal character #{t.value}"
        t.lexer.pos += 1
        nil
      end

    end # class
  end # module
end # module
